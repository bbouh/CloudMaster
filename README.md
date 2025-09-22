# CloudMaster - Comprehensive Cloud Computing Education Platform

![CloudMaster Logo](https://via.placeholder.com/200x80/3B82F6/FFFFFF?text=CloudMaster)

**CloudMaster** is a comprehensive, full-stack cloud computing education platform designed to teach cloud technologies from beginner to expert level. The platform offers interactive lessons, hands-on labs, practical projects, and certification paths for AWS, Azure, GCP, DevOps, SRE, and cloud security.

## 🌟 Features

### 🎓 Educational Content
- **Comprehensive Curriculum**: 15+ learning paths covering all major cloud platforms
- **Interactive Lessons**: Step-by-step tutorials with real-world examples
- **Hands-on Labs**: Practical exercises with Terraform, CloudFormation, and ARM templates
- **Project-based Learning**: Real-world projects for different skill levels
- **Certification Preparation**: Practice exams for AWS, Azure, and GCP certifications

### 🛠️ Technical Features
- **Modern Tech Stack**: React, Node.js, PostgreSQL, Redis
- **Multi-language Support**: Arabic and English with i18n
- **Responsive Design**: Mobile-first approach with TailwindCSS
- **Real-time Progress**: Track learning progress and achievements
- **Interactive Labs**: Deploy real infrastructure in cloud environments
- **Certificate Generation**: Automated PDF certificate creation

### 🔐 Security & Authentication
- **JWT Authentication**: Secure token-based authentication
- **OAuth Integration**: Google and GitHub login support
- **Role-based Access**: Student, Instructor, and Admin roles
- **Security Best Practices**: OWASP compliance and data encryption

### 📊 Analytics & Monitoring
- **Learning Analytics**: Track student progress and engagement
- **Performance Metrics**: Monitor platform performance
- **Cost Tracking**: Estimate and track cloud lab costs
- **Admin Dashboard**: Comprehensive management interface

## 🚀 Quick Start

### Prerequisites

- **Node.js**: Version 18 or higher
- **npm**: Version 8 or higher
- **Docker**: For containerized deployment
- **PostgreSQL**: Version 15 or higher
- **Redis**: Version 7 or higher
- **AWS Account**: For cloud labs (optional)

### Local Development Setup

1. **Clone the repository**
   ```bash
   git clone git@github.com:bbouh/CloudMaster.git
   cd cloudmaster-platform
   ```

2. **Install dependencies**
   ```bash
   npm run setup
   ```

3. **Set up environment variables**
   ```bash
   # Copy environment files
   cp backend/.env.example backend/.env
   cp frontend/.env.example frontend/.env
   
   # Edit the environment files with your configuration
   nano backend/.env
   nano frontend/.env
   ```

4. **Start the development environment**
   ```bash
   # Using Docker Compose (Recommended)
   docker-compose up -d
   
   # Or run locally
   npm run dev
   ```

5. **Access the application**
   - Frontend: http://localhost:3000
   - Backend API: http://localhost:3001
   - API Documentation: http://localhost:3001/api-docs

### Environment Variables

#### Backend (.env)
```env
# Database
DATABASE_URL="postgresql://username:password@localhost:5432/cloudmaster"

# Redis
REDIS_URL="redis://localhost:6379"

# JWT Secrets
JWT_SECRET="your-super-secret-jwt-key"
JWT_REFRESH_SECRET="your-super-secret-refresh-key"

# OAuth
GOOGLE_CLIENT_ID="your-google-client-id"
GOOGLE_CLIENT_SECRET="your-google-client-secret"
GITHUB_CLIENT_ID="your-github-client-id"
GITHUB_CLIENT_SECRET="your-github-client-secret"

# Payment
STRIPE_SECRET_KEY="your-stripe-secret-key"
STRIPE_WEBHOOK_SECRET="your-stripe-webhook-secret"

# Email
SMTP_HOST="smtp.gmail.com"
SMTP_PORT="587"
SMTP_USER="your-email@gmail.com"
SMTP_PASS="your-app-password"

# AWS (for labs)
AWS_ACCESS_KEY_ID="your-aws-access-key"
AWS_SECRET_ACCESS_KEY="your-aws-secret-key"
AWS_REGION="us-east-1"
```

#### Frontend (.env)
```env
REACT_APP_API_URL="http://localhost:3001"
REACT_APP_STRIPE_PUBLISHABLE_KEY="your-stripe-publishable-key"
REACT_APP_GOOGLE_CLIENT_ID="your-google-client-id"
REACT_APP_GITHUB_CLIENT_ID="your-github-client-id"
```

## 📚 Learning Paths

### 🌩️ Cloud Fundamentals
- **Cloud Computing Basics**: IaaS, PaaS, SaaS concepts
- **Cloud Architecture**: Design patterns and best practices
- **Cost Optimization**: Strategies for reducing cloud costs
- **Security Fundamentals**: Cloud security principles

### ☁️ AWS Path
- **AWS Fundamentals**: Core services and concepts
- **Compute Services**: EC2, Lambda, ECS, EKS
- **Storage Services**: S3, EBS, EFS, Glacier
- **Database Services**: RDS, DynamoDB, ElastiCache
- **Networking**: VPC, CloudFront, Route 53
- **Security**: IAM, KMS, WAF, Shield
- **DevOps**: CodePipeline, CodeBuild, CodeDeploy

### 🔵 Azure Path
- **Azure Fundamentals**: Core services and concepts
- **Compute Services**: Virtual Machines, App Service, Functions
- **Storage Services**: Blob Storage, File Storage, Disk Storage
- **Database Services**: SQL Database, Cosmos DB, Redis Cache
- **Networking**: Virtual Network, Load Balancer, CDN
- **Security**: Azure AD, Key Vault, Security Center
- **DevOps**: Azure DevOps, GitHub Actions

### 🟡 GCP Path
- **GCP Fundamentals**: Core services and concepts
- **Compute Services**: Compute Engine, Cloud Functions, GKE
- **Storage Services**: Cloud Storage, Persistent Disk
- **Database Services**: Cloud SQL, Firestore, BigQuery
- **Networking**: VPC, Cloud CDN, Cloud DNS
- **Security**: IAM, Secret Manager, Security Command Center
- **DevOps**: Cloud Build, Cloud Deploy

### 🔧 DevOps & SRE
- **Infrastructure as Code**: Terraform, CloudFormation, ARM
- **CI/CD Pipelines**: GitHub Actions, GitLab CI, Jenkins
- **Containerization**: Docker, Kubernetes
- **Monitoring**: Prometheus, Grafana, CloudWatch
- **Logging**: ELK Stack, Cloud Logging
- **Incident Response**: SRE practices and runbooks

## 🧪 Hands-on Labs

### Beginner Labs
- **Lab 1**: Deploy a Web Server on AWS EC2
- **Lab 2**: Create and Configure S3 Buckets
- **Lab 3**: Set up a MySQL Database on RDS
- **Lab 4**: Configure VPC and Security Groups
- **Lab 5**: Deploy a Static Website with CloudFront

### Intermediate Labs
- **Lab 6**: Build a CI/CD Pipeline with GitHub Actions
- **Lab 7**: Deploy a Microservices Application on EKS
- **Lab 8**: Set up Monitoring with CloudWatch and Prometheus
- **Lab 9**: Implement Infrastructure as Code with Terraform
- **Lab 10**: Configure Auto Scaling and Load Balancing

### Advanced Labs
- **Lab 11**: Multi-region Disaster Recovery Setup
- **Lab 12**: Serverless Architecture with Lambda and API Gateway
- **Lab 13**: Data Pipeline with Kinesis and Redshift
- **Lab 14**: Security Hardening and Compliance
- **Lab 15**: Cost Optimization and Resource Management

## 🏗️ Project Structure

```
cloudmaster-platform/
├── frontend/                 # React frontend application
│   ├── src/
│   │   ├── components/      # Reusable UI components
│   │   ├── pages/          # Page components
│   │   ├── contexts/       # React contexts
│   │   ├── hooks/          # Custom React hooks
│   │   ├── services/       # API services
│   │   └── utils/          # Utility functions
│   ├── public/             # Static assets
│   └── package.json
├── backend/                 # Node.js backend application
│   ├── src/
│   │   ├── routes/         # API routes
│   │   ├── middleware/     # Express middleware
│   │   ├── models/         # Database models
│   │   ├── services/       # Business logic
│   │   └── utils/          # Utility functions
│   ├── prisma/             # Database schema and migrations
│   └── package.json
├── content/                 # Educational content
│   ├── lessons/            # Lesson markdown files
│   ├── labs/               # Lab instructions and code
│   ├── quizzes/            # Quiz questions and answers
│   └── projects/           # Project specifications
├── infrastructure/          # Infrastructure as Code
│   ├── terraform/          # Terraform configurations
│   ├── docker/             # Docker configurations
│   └── k8s/                # Kubernetes manifests
├── docs/                   # Documentation
├── tests/                  # Test files
└── scripts/                # Utility scripts
```

## 🧪 Testing

### Run Tests
```bash
# Run all tests
npm test

# Run frontend tests
npm run test:frontend

# Run backend tests
npm run test:backend

# Run tests with coverage
npm run test:coverage
```

### Test Coverage
- **Frontend**: Jest + React Testing Library
- **Backend**: Jest + Supertest
- **E2E**: Playwright (optional)

## 🚀 Deployment

### Staging Deployment
```bash
# Deploy to staging
npm run deploy:staging

# Or using Terraform
cd infrastructure
terraform workspace select staging
terraform plan
terraform apply
```

### Production Deployment
```bash
# Deploy to production
npm run deploy:production

# Or using Terraform
cd infrastructure
terraform workspace select production
terraform plan
terraform apply
```

### Docker Deployment
```bash
# Build and run with Docker Compose
docker-compose -f docker-compose.prod.yml up -d

# Or build individual images
docker build -t cloudmaster-frontend ./frontend
docker build -t cloudmaster-backend ./backend
```

## 📊 Monitoring and Analytics

### Application Monitoring
- **Health Checks**: `/health` endpoint for service status
- **Metrics**: Prometheus metrics for performance monitoring
- **Logging**: Structured logging with Winston
- **Error Tracking**: Sentry integration for error monitoring

### Learning Analytics
- **Progress Tracking**: Student learning progress and completion rates
- **Engagement Metrics**: Time spent on lessons and labs
- **Performance Analytics**: Quiz scores and lab completion rates
- **Cost Tracking**: Cloud resource usage and cost estimation

## 🔒 Security

### Security Features
- **Authentication**: JWT-based authentication with refresh tokens
- **Authorization**: Role-based access control (RBAC)
- **Data Encryption**: Encryption at rest and in transit
- **Input Validation**: Comprehensive input validation and sanitization
- **Rate Limiting**: API rate limiting to prevent abuse
- **CORS**: Configured CORS policies
- **Security Headers**: Helmet.js for security headers

### Security Best Practices
- **OWASP Compliance**: Following OWASP security guidelines
- **Secrets Management**: Environment variables for sensitive data
- **Regular Updates**: Automated dependency updates
- **Security Scanning**: Automated security vulnerability scanning
- **Access Logging**: Comprehensive access and audit logging

## 🤝 Contributing

We welcome contributions to CloudMaster! Please see our [Contributing Guide](CONTRIBUTING.md) for details.

### Development Workflow
1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests for new functionality
5. Ensure all tests pass
6. Submit a pull request

### Code Standards
- **ESLint**: Code linting and formatting
- **Prettier**: Code formatting
- **TypeScript**: Type safety
- **Conventional Commits**: Commit message format

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🆘 Support

### Getting Help
- **Documentation**: Check our comprehensive documentation
- **Issues**: Report bugs and request features on GitHub
- **Discussions**: Join our community discussions
- **Email**: Contact us at support@cloudmaster.com

### Community
- **Discord**: Join our Discord server
- **Slack**: Join our Slack workspace
- **Twitter**: Follow us on Twitter
- **LinkedIn**: Connect with us on LinkedIn

## 🎯 Roadmap

### Q1 2024
- [ ] Mobile app development
- [ ] Advanced analytics dashboard
- [ ] AI-powered learning recommendations
- [ ] Multi-tenant architecture

### Q2 2024
- [ ] Enterprise features
- [ ] Advanced security features
- [ ] Performance optimizations
- [ ] Additional cloud providers

### Q3 2024
- [ ] Machine learning integration
- [ ] Advanced project templates
- [ ] Community features
- [ ] API marketplace

## 🙏 Acknowledgments

- **AWS**: For providing comprehensive cloud services
- **Microsoft Azure**: For enterprise-grade cloud solutions
- **Google Cloud**: For innovative cloud technologies
- **Open Source Community**: For amazing tools and libraries
- **Contributors**: Thank you to all contributors who make this project possible

---

**Made with ❤️ by the CloudMaster Team**

For more information, visit our [website](https://cloudmaster.com) or check out our [documentation](https://docs.cloudmaster.com).
