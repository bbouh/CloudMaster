#!/bin/bash

# CloudMaster Platform Setup Script
# This script sets up the development environment for CloudMaster

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

# Function to check system requirements
check_requirements() {
    print_status "Checking system requirements..."
    
    # Check Node.js
    if command_exists node; then
        NODE_VERSION=$(node --version)
        print_success "Node.js found: $NODE_VERSION"
    else
        print_error "Node.js is not installed. Please install Node.js 18 or higher."
        exit 1
    fi
    
    # Check npm
    if command_exists npm; then
        NPM_VERSION=$(npm --version)
        print_success "npm found: $NPM_VERSION"
    else
        print_error "npm is not installed. Please install npm."
        exit 1
    fi
    
    # Check Docker
    if command_exists docker; then
        DOCKER_VERSION=$(docker --version)
        print_success "Docker found: $DOCKER_VERSION"
    else
        print_warning "Docker is not installed. Docker is required for containerized deployment."
    fi
    
    # Check Docker Compose
    if command_exists docker-compose; then
        COMPOSE_VERSION=$(docker-compose --version)
        print_success "Docker Compose found: $COMPOSE_VERSION"
    else
        print_warning "Docker Compose is not installed. Docker Compose is required for containerized deployment."
    fi
    
    # Check Git
    if command_exists git; then
        GIT_VERSION=$(git --version)
        print_success "Git found: $GIT_VERSION"
    else
        print_error "Git is not installed. Please install Git."
        exit 1
    fi
}

# Function to create environment files
create_env_files() {
    print_status "Creating environment files..."
    
    # Backend .env
    if [ ! -f "backend/.env" ]; then
        cp backend/.env.example backend/.env
        print_success "Created backend/.env from template"
    else
        print_warning "backend/.env already exists, skipping..."
    fi
    
    # Frontend .env
    if [ ! -f "frontend/.env" ]; then
        cp frontend/.env.example frontend/.env
        print_success "Created frontend/.env from template"
    else
        print_warning "frontend/.env already exists, skipping..."
    fi
    
    # Docker .env
    if [ ! -f ".env" ]; then
        cp .env.example .env
        print_success "Created .env from template"
    else
        print_warning ".env already exists, skipping..."
    fi
}

# Function to install dependencies
install_dependencies() {
    print_status "Installing dependencies..."
    
    # Install root dependencies
    print_status "Installing root dependencies..."
    npm install
    
    # Install backend dependencies
    print_status "Installing backend dependencies..."
    cd backend
    npm install
    cd ..
    
    # Install frontend dependencies
    print_status "Installing frontend dependencies..."
    cd frontend
    npm install
    cd ..
    
    print_success "All dependencies installed successfully"
}

# Function to setup database
setup_database() {
    print_status "Setting up database..."
    
    # Check if PostgreSQL is running
    if command_exists psql; then
        print_status "PostgreSQL found, setting up database..."
        cd backend
        
        # Generate Prisma client
        npm run db:generate
        
        # Run database migrations
        npm run db:push
        
        # Seed database
        npm run db:seed
        
        cd ..
        print_success "Database setup completed"
    else
        print_warning "PostgreSQL is not installed. Please install PostgreSQL or use Docker."
        print_status "You can start the database using Docker Compose:"
        print_status "docker-compose up -d postgres"
    fi
}

# Function to setup Redis
setup_redis() {
    print_status "Setting up Redis..."
    
    # Check if Redis is running
    if command_exists redis-cli; then
        print_status "Redis found, testing connection..."
        if redis-cli ping >/dev/null 2>&1; then
            print_success "Redis is running and accessible"
        else
            print_warning "Redis is not running. Please start Redis or use Docker."
            print_status "You can start Redis using Docker Compose:"
            print_status "docker-compose up -d redis"
        fi
    else
        print_warning "Redis is not installed. Please install Redis or use Docker."
        print_status "You can start Redis using Docker Compose:"
        print_status "docker-compose up -d redis"
    fi
}

# Function to build applications
build_applications() {
    print_status "Building applications..."
    
    # Build backend
    print_status "Building backend..."
    cd backend
    npm run build
    cd ..
    
    # Build frontend
    print_status "Building frontend..."
    cd frontend
    npm run build
    cd ..
    
    print_success "Applications built successfully"
}

# Function to run tests
run_tests() {
    print_status "Running tests..."
    
    # Run backend tests
    print_status "Running backend tests..."
    cd backend
    npm test
    cd ..
    
    # Run frontend tests
    print_status "Running frontend tests..."
    cd frontend
    npm test -- --watchAll=false
    cd ..
    
    print_success "All tests passed"
}

# Function to start development environment
start_dev_environment() {
    print_status "Starting development environment..."
    
    # Start with Docker Compose if available
    if command_exists docker-compose; then
        print_status "Starting services with Docker Compose..."
        docker-compose up -d postgres redis
        
        # Wait for services to be ready
        print_status "Waiting for services to be ready..."
        sleep 10
        
        # Start applications
        print_status "Starting applications..."
        npm run dev
    else
        print_status "Starting applications without Docker..."
        npm run dev
    fi
}

# Function to show help
show_help() {
    echo "CloudMaster Platform Setup Script"
    echo ""
    echo "Usage: $0 [OPTIONS]"
    echo ""
    echo "Options:"
    echo "  --help, -h          Show this help message"
    echo "  --check             Check system requirements only"
    echo "  --env               Create environment files only"
    echo "  --install           Install dependencies only"
    echo "  --database          Setup database only"
    echo "  --redis             Setup Redis only"
    echo "  --build             Build applications only"
    echo "  --test              Run tests only"
    echo "  --start             Start development environment"
    echo "  --all               Run all setup steps (default)"
    echo ""
    echo "Examples:"
    echo "  $0                  # Run all setup steps"
    echo "  $0 --check          # Check system requirements"
    echo "  $0 --install        # Install dependencies only"
    echo "  $0 --start          # Start development environment"
}

# Main function
main() {
    print_status "Starting CloudMaster Platform Setup..."
    
    # Parse command line arguments
    case "${1:-}" in
        --help|-h)
            show_help
            exit 0
            ;;
        --check)
            check_requirements
            exit 0
            ;;
        --env)
            create_env_files
            exit 0
            ;;
        --install)
            check_requirements
            install_dependencies
            exit 0
            ;;
        --database)
            setup_database
            exit 0
            ;;
        --redis)
            setup_redis
            exit 0
            ;;
        --build)
            build_applications
            exit 0
            ;;
        --test)
            run_tests
            exit 0
            ;;
        --start)
            start_dev_environment
            exit 0
            ;;
        --all|"")
            check_requirements
            create_env_files
            install_dependencies
            setup_database
            setup_redis
            build_applications
            run_tests
            print_success "Setup completed successfully!"
            print_status "You can now start the development environment with:"
            print_status "npm run dev"
            print_status "Or with Docker Compose:"
            print_status "docker-compose up"
            ;;
        *)
            print_error "Unknown option: $1"
            show_help
            exit 1
            ;;
    esac
}

# Run main function
main "$@"
