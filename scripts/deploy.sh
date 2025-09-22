#!/bin/bash

# CloudMaster Deployment Script
# This script handles deployment to different environments

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Function to check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to check prerequisites
check_prerequisites() {
    print_status "Checking deployment prerequisites..."
    
    # Check required tools
    local required_tools=("docker" "docker-compose" "aws" "terraform")
    
    for tool in "${required_tools[@]}"; do
        if command_exists "$tool"; then
            print_success "$tool is installed"
        else
            print_error "$tool is not installed. Please install it before deploying."
            exit 1
        fi
    done
    
    # Check AWS credentials
    if aws sts get-caller-identity >/dev/null 2>&1; then
        print_success "AWS credentials are configured"
    else
        print_error "AWS credentials are not configured. Please run 'aws configure'."
        exit 1
    fi
    
    # Check environment variables
    if [ -z "$AWS_REGION" ]; then
        export AWS_REGION="us-east-1"
        print_warning "AWS_REGION not set, using default: us-east-1"
    fi
}

# Function to build Docker images
build_images() {
    print_status "Building Docker images..."
    
    # Build backend image
    print_status "Building backend image..."
    docker build -t cloudmaster-backend:latest ./backend
    
    # Build frontend image
    print_status "Building frontend image..."
    docker build -t cloudmaster-frontend:latest ./frontend
    
    print_success "Docker images built successfully"
}

# Function to push images to ECR
push_to_ecr() {
    local environment=$1
    local aws_region=${AWS_REGION:-us-east-1}
    local account_id=$(aws sts get-caller-identity --query Account --output text)
    
    print_status "Pushing images to ECR..."
    
    # Login to ECR
    aws ecr get-login-password --region $aws_region | docker login --username AWS --password-stdin $account_id.dkr.ecr.$aws_region.amazonaws.com
    
    # Tag and push backend image
    docker tag cloudmaster-backend:latest $account_id.dkr.ecr.$aws_region.amazonaws.com/cloudmaster-backend:$environment
    docker push $account_id.dkr.ecr.$aws_region.amazonaws.com/cloudmaster-backend:$environment
    
    # Tag and push frontend image
    docker tag cloudmaster-frontend:latest $account_id.dkr.ecr.$aws_region.amazonaws.com/cloudmaster-frontend:$environment
    docker push $account_id.dkr.ecr.$aws_region.amazonaws.com/cloudmaster-frontend:$environment
    
    print_success "Images pushed to ECR successfully"
}

# Function to deploy infrastructure
deploy_infrastructure() {
    local environment=$1
    
    print_status "Deploying infrastructure for $environment..."
    
    cd infrastructure/terraform
    
    # Initialize Terraform
    terraform init
    
    # Select workspace
    terraform workspace select $environment || terraform workspace new $environment
    
    # Plan deployment
    terraform plan -var="environment=$environment" -out=tfplan
    
    # Apply deployment
    terraform apply tfplan
    
    cd ../..
    
    print_success "Infrastructure deployed successfully"
}

# Function to deploy application
deploy_application() {
    local environment=$1
    
    print_status "Deploying application to $environment..."
    
    # Update ECS service
    aws ecs update-service \
        --cluster cloudmaster-$environment \
        --service cloudmaster-backend \
        --force-new-deployment \
        --region ${AWS_REGION:-us-east-1}
    
    aws ecs update-service \
        --cluster cloudmaster-$environment \
        --service cloudmaster-frontend \
        --force-new-deployment \
        --region ${AWS_REGION:-us-east-1}
    
    print_success "Application deployed successfully"
}

# Function to run database migrations
run_migrations() {
    local environment=$1
    
    print_status "Running database migrations for $environment..."
    
    # Get database endpoint from Terraform output
    cd infrastructure/terraform
    local db_endpoint=$(terraform output -raw rds_endpoint)
    cd ../..
    
    # Run migrations
    docker run --rm \
        -e DATABASE_URL="postgresql://cloudmaster:password@$db_endpoint:5432/cloudmaster" \
        cloudmaster-backend:latest \
        npm run db:migrate
    
    print_success "Database migrations completed"
}

# Function to run tests
run_tests() {
    print_status "Running tests..."
    
    # Run backend tests
    cd backend
    npm test
    cd ..
    
    # Run frontend tests
    cd frontend
    npm test -- --watchAll=false
    cd ..
    
    print_success "All tests passed"
}

# Function to deploy to staging
deploy_staging() {
    print_status "Deploying to staging environment..."
    
    check_prerequisites
    run_tests
    build_images
    push_to_ecr "staging"
    deploy_infrastructure "staging"
    run_migrations "staging"
    deploy_application "staging"
    
    print_success "Staging deployment completed successfully!"
    print_status "Application URL: https://staging.cloudmaster.com"
}

# Function to deploy to production
deploy_production() {
    print_status "Deploying to production environment..."
    
    # Confirm production deployment
    read -p "Are you sure you want to deploy to production? (yes/no): " confirm
    if [ "$confirm" != "yes" ]; then
        print_error "Production deployment cancelled"
        exit 1
    fi
    
    check_prerequisites
    run_tests
    build_images
    push_to_ecr "production"
    deploy_infrastructure "production"
    run_migrations "production"
    deploy_application "production"
    
    print_success "Production deployment completed successfully!"
    print_status "Application URL: https://cloudmaster.com"
}

# Function to rollback deployment
rollback_deployment() {
    local environment=$1
    
    print_status "Rolling back $environment deployment..."
    
    # Get previous task definition
    local previous_task_def=$(aws ecs describe-services \
        --cluster cloudmaster-$environment \
        --services cloudmaster-backend \
        --region ${AWS_REGION:-us-east-1} \
        --query 'services[0].deployments[1].taskDefinition' \
        --output text)
    
    if [ "$previous_task_def" != "None" ] && [ "$previous_task_def" != "null" ]; then
        # Update service to previous task definition
        aws ecs update-service \
            --cluster cloudmaster-$environment \
            --service cloudmaster-backend \
            --task-definition $previous_task_def \
            --region ${AWS_REGION:-us-east-1}
        
        print_success "Rollback completed successfully"
    else
        print_error "No previous deployment found to rollback to"
        exit 1
    fi
}

# Function to show help
show_help() {
    echo "CloudMaster Deployment Script"
    echo ""
    echo "Usage: $0 [COMMAND] [OPTIONS]"
    echo ""
    echo "Commands:"
    echo "  staging              Deploy to staging environment"
    echo "  production           Deploy to production environment"
    echo "  rollback [env]       Rollback deployment for environment"
    echo "  test                 Run tests only"
    echo "  build                Build Docker images only"
    echo "  infrastructure [env] Deploy infrastructure only"
    echo "  help                 Show this help message"
    echo ""
    echo "Options:"
    echo "  --region REGION      AWS region (default: us-east-1)"
    echo "  --skip-tests         Skip running tests"
    echo "  --skip-build         Skip building Docker images"
    echo ""
    echo "Examples:"
    echo "  $0 staging                    # Deploy to staging"
    echo "  $0 production                 # Deploy to production"
    echo "  $0 rollback staging           # Rollback staging deployment"
    echo "  $0 infrastructure production  # Deploy infrastructure only"
    echo "  $0 --region us-west-2 staging # Deploy to staging in us-west-2"
    echo ""
    echo "Environment Variables:"
    echo "  AWS_REGION          AWS region for deployment"
    echo "  AWS_ACCESS_KEY_ID   AWS access key ID"
    echo "  AWS_SECRET_ACCESS_KEY AWS secret access key"
}

# Parse command line arguments
SKIP_TESTS=false
SKIP_BUILD=false

while [[ $# -gt 0 ]]; do
    case $1 in
        --region)
            export AWS_REGION="$2"
            shift 2
            ;;
        --skip-tests)
            SKIP_TESTS=true
            shift
            ;;
        --skip-build)
            SKIP_BUILD=true
            shift
            ;;
        --help|-h)
            show_help
            exit 0
            ;;
        *)
            COMMAND="$1"
            shift
            ;;
    esac
done

# Main deployment logic
case "${COMMAND:-}" in
    staging)
        deploy_staging
        ;;
    production)
        deploy_production
        ;;
    rollback)
        if [ -z "$1" ]; then
            print_error "Please specify environment for rollback"
            exit 1
        fi
        rollback_deployment "$1"
        ;;
    test)
        run_tests
        ;;
    build)
        build_images
        ;;
    infrastructure)
        if [ -z "$1" ]; then
            print_error "Please specify environment for infrastructure deployment"
            exit 1
        fi
        deploy_infrastructure "$1"
        ;;
    help|"")
        show_help
        ;;
    *)
        print_error "Unknown command: $COMMAND"
        show_help
        exit 1
        ;;
esac
