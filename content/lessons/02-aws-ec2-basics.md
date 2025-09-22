---
id: "02-aws-ec2-basics"
title: "AWS EC2 Basics - Launching Your First Instance"
title_ar: "أساسيات AWS EC2 - تشغيل أول مثيل"
slug: "aws-ec2-basics"
course_id: "aws-fundamentals"
level: "BEGINNER"
duration_minutes: 60
difficulty: 2
prerequisites: ["01-cloud-fundamentals"]
learning_outcomes:
  - "Understand what Amazon EC2 is and its core concepts"
  - "Learn about EC2 instance types and their use cases"
  - "Launch and configure your first EC2 instance"
  - "Connect to an EC2 instance using SSH"
  - "Understand security groups and key pairs"
assets:
  code_files: ["ec2-setup.sh", "web-server-setup.sh"]
  terraform_files: ["ec2-instance.tf"]
  videos: ["aws-ec2-basics.mp4"]
quiz_id: "quiz-ec2-basics"
tags: ["aws", "ec2", "compute", "instances", "security-groups"]
keywords: ["Amazon EC2", "virtual machines", "instance types", "security groups", "key pairs"]
---

# AWS EC2 Basics - Launching Your First Instance

## Introduction

Amazon Elastic Compute Cloud (EC2) is one of the most fundamental AWS services. It provides resizable compute capacity in the cloud, allowing you to launch virtual servers called instances. In this lesson, you'll learn how to launch your first EC2 instance and understand the core concepts that make EC2 so powerful.

## What is Amazon EC2?

Amazon EC2 is a web service that provides secure, resizable compute capacity in the cloud. It's designed to make web-scale cloud computing easier for developers by providing:

- **Virtual servers**: Launch instances with different operating systems
- **Scalability**: Scale capacity up or down within minutes
- **Flexibility**: Choose from various instance types, operating systems, and software packages
- **Cost-effectiveness**: Pay only for what you use
- **Security**: Built-in security features and network isolation

## EC2 Instance Types

AWS offers various instance types optimized for different use cases:

### General Purpose (M5, M5a, M5n, M6i, M6a)

**Best for**: Web servers, development environments, small to medium databases

**Characteristics**:
- Balanced compute, memory, and networking resources
- Cost-effective for diverse workloads
- Good for applications that don't need specialized hardware

**Example**: `t3.micro` - 1 vCPU, 1 GB RAM (Free tier eligible)

### Compute Optimized (C5, C5n, C6i, C6a)

**Best for**: High-performance web servers, scientific modeling, batch processing

**Characteristics**:
- High CPU-to-memory ratio
- Optimized for compute-intensive applications
- Good for applications that benefit from high-performance processors

**Example**: `c5.large` - 2 vCPUs, 4 GB RAM

### Memory Optimized (R5, R5a, R5n, R6i, R6a)

**Best for**: High-performance databases, in-memory caches, real-time analytics

**Characteristics**:
- High memory-to-CPU ratio
- Optimized for memory-intensive applications
- Good for applications that process large datasets in memory

**Example**: `r5.xlarge` - 4 vCPUs, 32 GB RAM

### Storage Optimized (I3, I3en, D2, D3, D3en)

**Best for**: NoSQL databases, data warehousing, log processing

**Characteristics**:
- High, sequential read and write access to very large datasets
- Optimized for applications that require high, sequential read and write access
- Good for applications that need high IOPS

**Example**: `i3.large` - 2 vCPUs, 15.25 GB RAM, 475 GB NVMe SSD

## Hands-On Lab: Launching Your First EC2 Instance

### Step 1: Access the AWS Management Console

1. Log in to your AWS account
2. Navigate to the EC2 service
3. Click "Launch Instance"

### Step 2: Choose an Amazon Machine Image (AMI)

An AMI is a template that contains the software configuration (operating system, application server, and applications) required to launch your instance.

**For this lab, we'll use:**
- **AMI**: Amazon Linux 2 AMI (HVM) - SSD Volume Type
- **Architecture**: 64-bit (x86)
- **Virtualization**: HVM

### Step 3: Choose an Instance Type

For this lab, we'll use:
- **Instance Type**: t2.micro (Free tier eligible)
- **vCPUs**: 1
- **Memory**: 1 GB
- **Network Performance**: Low to Moderate

### Step 4: Configure Instance Details

**Key settings:**
- **Number of instances**: 1
- **Purchasing option**: Keep default (On-Demand)
- **Network**: Default VPC
- **Subnet**: Default subnet
- **Auto-assign Public IP**: Enable

### Step 5: Add Storage

- **Volume Type**: General Purpose SSD (gp2)
- **Size**: 8 GB (Free tier limit)
- **Encryption**: Not encrypted (for this lab)

### Step 6: Add Tags

Tags help you organize and identify your resources:

```
Key: Name
Value: My-First-EC2-Instance
```

### Step 7: Configure Security Group

A security group acts as a virtual firewall that controls the traffic for your instance.

**Create a new security group:**
- **Security group name**: My-First-Security-Group
- **Description**: Security group for my first EC2 instance

**Add rules:**
1. **SSH (22)**: Source = My IP
2. **HTTP (80)**: Source = Anywhere (0.0.0.0/0)
3. **HTTPS (443)**: Source = Anywhere (0.0.0.0/0)

### Step 8: Review and Launch

1. Review your instance configuration
2. Click "Launch"
3. Select or create a key pair
4. Download the key pair file (.pem)
5. Click "Launch Instances"

## Connecting to Your EC2 Instance

### Using SSH (Linux/macOS)

```bash
# Change permissions on your key file
chmod 400 my-key-pair.pem

# Connect to your instance
ssh -i my-key-pair.pem ec2-user@your-instance-public-ip
```

### Using PuTTY (Windows)

1. Convert your .pem file to .ppk using PuTTYgen
2. Open PuTTY
3. Enter your instance's public IP address
4. Load your .ppk file in the SSH section
5. Click "Open"

## Setting Up a Web Server

Once connected to your instance, let's set up a simple web server:

```bash
# Update the system
sudo yum update -y

# Install Apache web server
sudo yum install -y httpd

# Start the web server
sudo systemctl start httpd

# Enable it to start on boot
sudo systemctl enable httpd

# Create a simple HTML page
sudo echo "<h1>Hello from my first EC2 instance!</h1>" > /var/www/html/index.html

# Check if the web server is running
sudo systemctl status httpd
```

## Understanding Security Groups

Security groups are stateful firewalls that control inbound and outbound traffic:

### Key Concepts:
- **Stateful**: Return traffic is automatically allowed
- **Default deny**: All inbound traffic is denied by default
- **Default allow**: All outbound traffic is allowed by default
- **Rules**: Can be added, modified, or removed at any time

### Common Ports:
- **22**: SSH
- **80**: HTTP
- **443**: HTTPS
- **3389**: RDP (Windows)
- **5432**: PostgreSQL
- **3306**: MySQL

## Key Pairs

Key pairs are used to securely connect to your EC2 instances:

### Best Practices:
- **Never share your private key**
- **Use different key pairs for different environments**
- **Store keys securely**
- **Use key pairs for Linux instances, passwords for Windows**

## Monitoring Your Instance

### CloudWatch Metrics

AWS automatically provides basic monitoring for EC2 instances:

- **CPU Utilization**
- **Network In/Out**
- **Disk Read/Write**
- **Status Checks**

### Instance Status Checks

AWS performs two types of status checks:

1. **System Status Checks**: Monitor AWS systems
2. **Instance Status Checks**: Monitor your instance's software and network configuration

## Cost Optimization Tips

### Free Tier Usage
- **750 hours/month** of t2.micro instances
- **30 GB** of EBS storage
- **2 million I/O requests**

### Cost-Saving Strategies
1. **Stop instances** when not in use
2. **Use Spot Instances** for fault-tolerant workloads
3. **Right-size instances** based on actual usage
4. **Use Reserved Instances** for predictable workloads

## Common Commands and Operations

### Instance Management
```bash
# Check instance status
aws ec2 describe-instances --instance-ids i-1234567890abcdef0

# Start an instance
aws ec2 start-instances --instance-ids i-1234567890abcdef0

# Stop an instance
aws ec2 stop-instances --instance-ids i-1234567890abcdef0

# Terminate an instance
aws ec2 terminate-instances --instance-ids i-1234567890abcdef0
```

### Security Group Management
```bash
# Create a security group
aws ec2 create-security-group --group-name my-sg --description "My security group"

# Add a rule to security group
aws ec2 authorize-security-group-ingress --group-id sg-12345678 --protocol tcp --port 22 --cidr 0.0.0.0/0
```

## Troubleshooting Common Issues

### Connection Issues
1. **Check security group rules**
2. **Verify key pair permissions**
3. **Ensure instance is running**
4. **Check network ACLs**

### Performance Issues
1. **Monitor CloudWatch metrics**
2. **Check instance type appropriateness**
3. **Review application configuration**
4. **Consider instance optimization**

## Security Best Practices

### Instance Security
1. **Use security groups** to control access
2. **Keep instances updated** with latest patches
3. **Use IAM roles** instead of access keys
4. **Enable detailed monitoring**

### Network Security
1. **Use VPC** for network isolation
2. **Implement least privilege** access
3. **Use private subnets** for sensitive instances
4. **Enable VPC Flow Logs**

## Real-World Use Cases

### Web Applications
- Host dynamic websites
- Run web servers (Apache, Nginx)
- Handle user requests and responses

### Development Environments
- Create isolated development environments
- Test applications before production
- Collaborate with team members

### Data Processing
- Run batch processing jobs
- Perform data analysis
- Handle ETL operations

## Summary

In this lesson, you've learned:

- **EC2 fundamentals**: What EC2 is and how it works
- **Instance types**: Different types and their use cases
- **Launching instances**: Step-by-step process
- **Security**: Security groups and key pairs
- **Connection**: How to connect to instances
- **Monitoring**: Basic monitoring and status checks
- **Best practices**: Security and cost optimization

## Next Steps

In the next lesson, we'll explore Amazon S3 (Simple Storage Service) and learn how to store and retrieve data in the cloud.

## Lab Exercise

1. Launch a t2.micro instance with Amazon Linux 2
2. Configure security group to allow SSH and HTTP access
3. Connect to the instance using SSH
4. Install and configure a web server
5. Create a simple HTML page
6. Access the page through your browser
7. Monitor the instance using CloudWatch

## Additional Resources

- [AWS EC2 Documentation](https://docs.aws.amazon.com/ec2/)
- [EC2 Instance Types](https://aws.amazon.com/ec2/instance-types/)
- [Security Groups Documentation](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/working-with-security-groups.html)

---

**Instructor Notes:**
- Emphasize the importance of security groups and key pairs
- Show students how to monitor costs in the AWS console
- Demonstrate both AWS console and CLI approaches
- Address common connection issues

**Potential Difficulties:**
- Students may struggle with SSH key permissions
- Understanding security group rules can be challenging
- Cost implications may not be immediately clear

**Assessment Points:**
- Can students successfully launch and connect to an EC2 instance?
- Do they understand the purpose of security groups?
- Can they explain different instance types and their use cases?
