---
id: "project-01-web-application"
title: "Project 1: Multi-Tier Web Application"
title_ar: "مشروع 1: تطبيق ويب متعدد المستويات"
slug: "multi-tier-web-application"
course_id: "aws-fundamentals"
level: "INTERMEDIATE"
duration_hours: 20
difficulty: 3
prerequisites: ["02-aws-ec2-basics", "03-aws-s3-fundamentals", "04-aws-rds-basics"]
learning_outcomes:
  - "Design and implement a multi-tier web application architecture"
  - "Deploy and configure web servers, application servers, and databases"
  - "Implement load balancing and auto-scaling"
  - "Set up monitoring and logging"
  - "Implement security best practices"
  - "Optimize for performance and cost"
assets:
  code_files: ["web-app-frontend", "web-app-backend", "database-schema.sql"]
  terraform_files: ["multi-tier-infrastructure.tf"]
  videos: ["multi-tier-web-app.mp4"]
cost_estimate: 25.00
resources:
  - "EC2 instances (t3.small)"
  - "Application Load Balancer"
  - "RDS MySQL instance"
  - "S3 bucket for static assets"
  - "CloudWatch monitoring"
tags: ["aws", "web-application", "multi-tier", "load-balancing", "auto-scaling"]
keywords: ["multi-tier", "web application", "load balancer", "auto scaling", "RDS", "S3"]
---

# Project 1: Multi-Tier Web Application

## Project Overview

In this project, you'll design, implement, and deploy a complete multi-tier web application on AWS. This project will give you hands-on experience with core AWS services and best practices for building scalable, secure, and cost-effective web applications.

## Learning Objectives

By the end of this project, you will be able to:
- Design and implement a multi-tier web application architecture
- Deploy and configure web servers, application servers, and databases
- Implement load balancing and auto-scaling
- Set up monitoring and logging
- Implement security best practices
- Optimize for performance and cost

## Project Requirements

### Functional Requirements

1. **Web Application**
   - User registration and authentication
   - User profile management
   - Content management system
   - Search functionality
   - File upload and storage
   - Responsive design

2. **Architecture Requirements**
   - Multi-tier architecture (Web, Application, Database)
   - High availability and fault tolerance
   - Auto-scaling capabilities
   - Load balancing
   - Database replication

3. **Security Requirements**
   - HTTPS encryption
   - User authentication and authorization
   - Input validation and sanitization
   - Security headers
   - Network security groups

4. **Performance Requirements**
   - Page load time < 3 seconds
   - Support for 1000+ concurrent users
   - Database query optimization
   - Caching implementation

### Technical Requirements

1. **Frontend**
   - React.js or Vue.js
   - Responsive design
   - Progressive Web App (PWA) features
   - Accessibility compliance (WCAG AA)

2. **Backend**
   - Node.js with Express.js
   - RESTful API design
   - JWT authentication
   - Input validation
   - Error handling

3. **Database**
   - MySQL or PostgreSQL
   - Database normalization
   - Indexing strategy
   - Backup and recovery

4. **Infrastructure**
   - AWS EC2 instances
   - Application Load Balancer
   - Auto Scaling Groups
   - RDS database
   - S3 for static assets
   - CloudFront CDN

## Architecture Design

### High-Level Architecture

```
Internet
    |
    | (HTTPS)
    |
[CloudFront CDN]
    |
    | (HTTPS)
    |
[Application Load Balancer]
    |
    | (HTTP)
    |
[Auto Scaling Group]
    |
    | (EC2 Instances)
    |
[Web Tier] -> [Application Tier] -> [Database Tier]
    |              |                    |
[Static Assets]  [Business Logic]    [RDS MySQL]
    |              |                    |
[S3 Bucket]    [Application Code]   [Read Replica]
```

### Detailed Component Design

#### Web Tier
- **EC2 Instances**: t3.small instances running Nginx
- **Auto Scaling**: Min 2, Max 10 instances
- **Load Balancer**: Application Load Balancer with health checks
- **Security**: Security groups allowing HTTP/HTTPS traffic

#### Application Tier
- **EC2 Instances**: t3.medium instances running Node.js
- **Auto Scaling**: Min 2, Max 8 instances
- **Load Balancer**: Internal Application Load Balancer
- **Security**: Security groups allowing traffic from web tier only

#### Database Tier
- **Primary Database**: RDS MySQL db.t3.micro
- **Read Replica**: RDS MySQL read replica for read operations
- **Backup**: Automated daily backups with 7-day retention
- **Security**: Security groups allowing traffic from application tier only

#### Storage Tier
- **S3 Bucket**: Static assets and file uploads
- **CloudFront**: CDN for global content delivery
- **IAM Roles**: Secure access to S3 resources

## Implementation Steps

### Phase 1: Infrastructure Setup (4 hours)

1. **Create VPC and Networking**
   ```bash
   # Create VPC with public and private subnets
   aws ec2 create-vpc --cidr-block 10.0.0.0/16
   
   # Create Internet Gateway
   aws ec2 create-internet-gateway
   
   # Create public and private subnets
   aws ec2 create-subnet --vpc-id vpc-xxx --cidr-block 10.0.1.0/24
   aws ec2 create-subnet --vpc-id vpc-xxx --cidr-block 10.0.2.0/24
   ```

2. **Set up Security Groups**
   ```bash
   # Web tier security group
   aws ec2 create-security-group --group-name web-tier-sg --description "Web tier security group"
   
   # Application tier security group
   aws ec2 create-security-group --group-name app-tier-sg --description "Application tier security group"
   
   # Database tier security group
   aws ec2 create-security-group --group-name db-tier-sg --description "Database tier security group"
   ```

3. **Create RDS Database**
   ```bash
   # Create RDS MySQL instance
   aws rds create-db-instance \
     --db-instance-identifier webapp-db \
     --db-instance-class db.t3.micro \
     --engine mysql \
     --master-username admin \
     --master-user-password YourPassword123 \
     --allocated-storage 20 \
     --vpc-security-group-ids sg-xxx
   ```

### Phase 2: Application Development (8 hours)

1. **Frontend Development**
   ```bash
   # Create React application
   npx create-react-app webapp-frontend
   cd webapp-frontend
   
   # Install dependencies
   npm install axios react-router-dom @mui/material @emotion/react @emotion/styled
   
   # Create components
   mkdir src/components
   mkdir src/pages
   mkdir src/services
   mkdir src/utils
   ```

2. **Backend Development**
   ```bash
   # Create Node.js application
   mkdir webapp-backend
   cd webapp-backend
   
   # Initialize project
   npm init -y
   
   # Install dependencies
   npm install express mysql2 bcryptjs jsonwebtoken cors helmet morgan
   npm install -D nodemon
   
   # Create project structure
   mkdir src
   mkdir src/controllers
   mkdir src/models
   mkdir src/routes
   mkdir src/middleware
   mkdir src/utils
   ```

3. **Database Schema**
   ```sql
   -- Create database
   CREATE DATABASE webapp;
   USE webapp;
   
   -- Users table
   CREATE TABLE users (
     id INT PRIMARY KEY AUTO_INCREMENT,
     username VARCHAR(50) UNIQUE NOT NULL,
     email VARCHAR(100) UNIQUE NOT NULL,
     password_hash VARCHAR(255) NOT NULL,
     first_name VARCHAR(50) NOT NULL,
     last_name VARCHAR(50) NOT NULL,
     created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
     updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
   );
   
   -- Posts table
   CREATE TABLE posts (
     id INT PRIMARY KEY AUTO_INCREMENT,
     title VARCHAR(200) NOT NULL,
     content TEXT NOT NULL,
     author_id INT NOT NULL,
     created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
     updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
     FOREIGN KEY (author_id) REFERENCES users(id) ON DELETE CASCADE
   );
   
   -- Comments table
   CREATE TABLE comments (
     id INT PRIMARY KEY AUTO_INCREMENT,
     content TEXT NOT NULL,
     post_id INT NOT NULL,
     author_id INT NOT NULL,
     created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
     FOREIGN KEY (post_id) REFERENCES posts(id) ON DELETE CASCADE,
     FOREIGN KEY (author_id) REFERENCES users(id) ON DELETE CASCADE
   );
   ```

### Phase 3: Deployment and Configuration (6 hours)

1. **Deploy Application Code**
   ```bash
   # Build frontend
   cd webapp-frontend
   npm run build
   
   # Upload to S3
   aws s3 sync build/ s3://webapp-static-assets
   
   # Deploy backend
   cd webapp-backend
   npm install --production
   
   # Create deployment package
   zip -r webapp-backend.zip .
   
   # Upload to EC2 instances
   scp -i key.pem webapp-backend.zip ec2-user@instance-ip:/home/ec2-user/
   ```

2. **Configure Load Balancer**
   ```bash
   # Create target group
   aws elbv2 create-target-group \
     --name webapp-targets \
     --protocol HTTP \
     --port 3000 \
     --vpc-id vpc-xxx
   
   # Create load balancer
   aws elbv2 create-load-balancer \
     --name webapp-alb \
     --subnets subnet-xxx subnet-yyy \
     --security-groups sg-xxx
   ```

3. **Set up Auto Scaling**
   ```bash
   # Create launch template
   aws ec2 create-launch-template \
     --launch-template-name webapp-template \
     --launch-template-data file://launch-template.json
   
   # Create auto scaling group
   aws autoscaling create-auto-scaling-group \
     --auto-scaling-group-name webapp-asg \
     --launch-template LaunchTemplateName=webapp-template \
     --min-size 2 \
     --max-size 10 \
     --desired-capacity 2 \
     --target-group-arns arn:aws:elasticloadbalancing:region:account:targetgroup/webapp-targets
   ```

### Phase 4: Monitoring and Optimization (2 hours)

1. **Set up CloudWatch Monitoring**
   ```bash
   # Create CloudWatch dashboard
   aws cloudwatch put-dashboard \
     --dashboard-name WebAppDashboard \
     --dashboard-body file://dashboard.json
   
   # Create alarms
   aws cloudwatch put-metric-alarm \
     --alarm-name HighCPUUsage \
     --alarm-description "High CPU usage" \
     --metric-name CPUUtilization \
     --namespace AWS/EC2 \
     --statistic Average \
     --period 300 \
     --threshold 80 \
     --comparison-operator GreaterThanThreshold
   ```

2. **Implement Logging**
   ```bash
   # Create CloudWatch log group
   aws logs create-log-group --log-group-name /aws/ec2/webapp
   
   # Configure log agent on EC2 instances
   sudo yum install -y amazon-cloudwatch-agent
   sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl \
     -a fetch-config -m ec2 -c file:cloudwatch-config.json -s
   ```

## Deliverables

### 1. Source Code
- Complete frontend application (React.js)
- Complete backend application (Node.js)
- Database schema and migrations
- Infrastructure as Code (Terraform)

### 2. Documentation
- Architecture design document
- API documentation
- Deployment guide
- User manual

### 3. Infrastructure
- Deployed multi-tier application
- Load balancer configuration
- Auto scaling setup
- Monitoring and alerting

### 4. Testing
- Unit tests for backend
- Integration tests
- Load testing results
- Security testing report

## Evaluation Criteria

### Technical Implementation (40%)
- **Architecture Design**: Proper multi-tier architecture
- **Code Quality**: Clean, maintainable, and well-documented code
- **Security**: Implementation of security best practices
- **Performance**: Optimization for speed and scalability

### AWS Services Usage (30%)
- **Service Selection**: Appropriate use of AWS services
- **Configuration**: Proper configuration of services
- **Integration**: Seamless integration between services
- **Cost Optimization**: Efficient use of resources

### Documentation and Presentation (20%)
- **Documentation**: Comprehensive and clear documentation
- **Presentation**: Clear explanation of design decisions
- **Code Comments**: Well-commented code
- **README**: Complete setup and usage instructions

### Testing and Quality Assurance (10%)
- **Testing**: Comprehensive test coverage
- **Quality**: Bug-free and reliable application
- **Performance**: Meets performance requirements
- **Security**: Passes security tests

## Submission Requirements

### 1. GitHub Repository
- Complete source code
- README with setup instructions
- Documentation in `/docs` folder
- Terraform files in `/infrastructure` folder

### 2. Live Demo
- Deployed application URL
- Demo of key features
- Performance metrics
- Monitoring dashboard

### 3. Written Report
- Architecture overview
- Implementation details
- Challenges faced and solutions
- Lessons learned
- Future improvements

## Timeline

- **Week 1**: Infrastructure setup and basic application development
- **Week 2**: Advanced features and deployment
- **Week 3**: Testing, optimization, and documentation
- **Week 4**: Final testing and submission

## Resources and References

### AWS Documentation
- [EC2 User Guide](https://docs.aws.amazon.com/ec2/)
- [RDS User Guide](https://docs.aws.amazon.com/rds/)
- [Application Load Balancer Guide](https://docs.aws.amazon.com/elasticloadbalancing/)
- [Auto Scaling User Guide](https://docs.aws.amazon.com/autoscaling/)

### Best Practices
- [AWS Well-Architected Framework](https://aws.amazon.com/architecture/well-architected/)
- [Security Best Practices](https://aws.amazon.com/security/security-resources/)
- [Performance Optimization](https://aws.amazon.com/performance/)

### Tools and Libraries
- [Terraform AWS Provider](https://registry.terraform.io/providers/hashicorp/aws/latest)
- [AWS CLI](https://aws.amazon.com/cli/)
- [AWS SDK for Node.js](https://aws.amazon.com/sdk-for-javascript/)

## Support and Help

### Getting Help
- **Instructor Office Hours**: Tuesdays and Thursdays, 2-4 PM
- **Slack Channel**: #project-1-support
- **Email**: instructor@cloudmaster.com
- **Documentation**: Check the course documentation

### Common Issues
- **Database Connection**: Check security groups and VPC configuration
- **Load Balancer**: Verify target group health checks
- **Auto Scaling**: Check launch template and scaling policies
- **Monitoring**: Ensure CloudWatch agent is properly configured

## Success Criteria

### Minimum Requirements
- Application is deployed and accessible
- All core features are working
- Basic monitoring is in place
- Documentation is complete

### Excellent Performance
- Application handles 1000+ concurrent users
- Page load times under 3 seconds
- 99.9% uptime
- Comprehensive monitoring and alerting
- Security best practices implemented
- Cost optimization strategies applied

## Next Steps

After completing this project, you'll be ready to:
- Take on more complex AWS projects
- Learn advanced AWS services
- Prepare for AWS certification exams
- Apply for cloud engineering positions

---

**Good luck with your project! Remember to start early, ask questions, and document your progress.**
