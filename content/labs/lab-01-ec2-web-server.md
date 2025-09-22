---
id: "lab-01-ec2-web-server"
title: "Lab 1: Deploy a Web Server on AWS EC2"
title_ar: "مختبر 1: نشر خادم ويب على AWS EC2"
slug: "ec2-web-server-lab"
course_id: "aws-fundamentals"
level: "BEGINNER"
duration_minutes: 90
difficulty: 2
prerequisites: ["02-aws-ec2-basics"]
learning_outcomes:
  - "Launch and configure an EC2 instance"
  - "Set up a web server (Apache/Nginx)"
  - "Configure security groups for web traffic"
  - "Deploy a simple web application"
  - "Monitor instance performance"
assets:
  code_files: ["web-server-setup.sh", "index.html", "app.js"]
  terraform_files: ["ec2-web-server.tf"]
  videos: ["ec2-web-server-lab.mp4"]
cost_estimate: 0.50
resources:
  - "EC2 t2.micro instance (1 hour)"
  - "EBS storage (8 GB)"
  - "Data transfer (minimal)"
tags: ["aws", "ec2", "web-server", "apache", "security-groups"]
keywords: ["EC2", "web server", "Apache", "security groups", "public IP"]
---

# Lab 1: Deploy a Web Server on AWS EC2

## Lab Overview

In this hands-on lab, you'll deploy a complete web server on AWS EC2. You'll learn how to launch an instance, configure security groups, install and configure a web server, and deploy a simple web application. This lab will give you practical experience with core AWS services and best practices.

## Learning Objectives

By the end of this lab, you will be able to:
- Launch and configure an EC2 instance
- Set up a web server (Apache/Nginx)
- Configure security groups for web traffic
- Deploy a simple web application
- Monitor instance performance
- Understand basic AWS networking concepts

## Prerequisites

- AWS account with appropriate permissions
- Basic understanding of Linux command line
- SSH client (PuTTY for Windows, Terminal for Mac/Linux)
- Text editor for creating configuration files

## Lab Architecture

```
Internet
    |
    | (HTTP/HTTPS)
    |
[Security Group]
    |
    | (Port 80, 443)
    |
[EC2 Instance]
    |
    | (Apache/Nginx)
    |
[Web Application]
```

## Step-by-Step Instructions

### Step 1: Launch EC2 Instance

1. **Log in to AWS Console**
   - Navigate to the EC2 service
   - Click "Launch Instance"

2. **Choose AMI**
   - Select "Amazon Linux 2 AMI (HVM) - SSD Volume Type"
   - Choose 64-bit (x86) architecture

3. **Choose Instance Type**
   - Select "t2.micro" (Free tier eligible)
   - Review the specifications:
     - 1 vCPU
     - 1 GB RAM
     - Network: Low to Moderate

4. **Configure Instance Details**
   - Number of instances: 1
   - Network: Default VPC
   - Subnet: Default subnet
   - Auto-assign Public IP: Enable
   - IAM role: None (for this lab)

5. **Add Storage**
   - Volume type: General Purpose SSD (gp2)
   - Size: 8 GB
   - Encryption: Not encrypted

6. **Add Tags**
   ```
   Key: Name
   Value: Web-Server-Lab
   
   Key: Environment
   Value: Lab
   
   Key: Project
   Value: CloudMaster
   ```

7. **Configure Security Group**
   - Create a new security group
   - Name: Web-Server-SG
   - Description: Security group for web server lab
   
   **Add the following rules:**
   ```
   Type: SSH
   Protocol: TCP
   Port: 22
   Source: My IP
   
   Type: HTTP
   Protocol: TCP
   Port: 80
   Source: 0.0.0.0/0
   
   Type: HTTPS
   Protocol: TCP
   Port: 443
   Source: 0.0.0.0/0
   ```

8. **Review and Launch**
   - Review your configuration
   - Select or create a key pair
   - Download the key pair file
   - Launch the instance

### Step 2: Connect to Your Instance

1. **Wait for Instance to be Running**
   - Check the instance state in the EC2 console
   - Note the public IP address

2. **Connect via SSH**
   ```bash
   # Change permissions on your key file
   chmod 400 your-key-pair.pem
   
   # Connect to your instance
   ssh -i your-key-pair.pem ec2-user@YOUR_PUBLIC_IP
   ```

### Step 3: Install and Configure Web Server

1. **Update the System**
   ```bash
   sudo yum update -y
   ```

2. **Install Apache Web Server**
   ```bash
   sudo yum install -y httpd
   ```

3. **Start and Enable Apache**
   ```bash
   # Start the service
   sudo systemctl start httpd
   
   # Enable it to start on boot
   sudo systemctl enable httpd
   
   # Check status
   sudo systemctl status httpd
   ```

4. **Configure Firewall**
   ```bash
   # Check if firewalld is running
   sudo systemctl status firewalld
   
   # If running, add HTTP and HTTPS services
   sudo firewall-cmd --permanent --add-service=http
   sudo firewall-cmd --permanent --add-service=https
   sudo firewall-cmd --reload
   ```

### Step 4: Create Web Content

1. **Create a Simple HTML Page**
   ```bash
   sudo nano /var/www/html/index.html
   ```
   
   Add the following content:
   ```html
   <!DOCTYPE html>
   <html lang="en">
   <head>
       <meta charset="UTF-8">
       <meta name="viewport" content="width=device-width, initial-scale=1.0">
       <title>CloudMaster Lab - Web Server</title>
       <style>
           body {
               font-family: Arial, sans-serif;
               max-width: 800px;
               margin: 0 auto;
               padding: 20px;
               background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
               color: white;
           }
           .container {
               background: rgba(255, 255, 255, 0.1);
               padding: 30px;
               border-radius: 10px;
               backdrop-filter: blur(10px);
           }
           h1 { color: #fff; text-align: center; }
           .info { background: rgba(255, 255, 255, 0.2); padding: 15px; border-radius: 5px; margin: 10px 0; }
           .success { color: #4CAF50; font-weight: bold; }
       </style>
   </head>
   <body>
       <div class="container">
           <h1>🚀 CloudMaster Lab - Web Server</h1>
           <div class="info">
               <h2>Congratulations!</h2>
               <p class="success">Your web server is running successfully on AWS EC2!</p>
           </div>
           <div class="info">
               <h3>Server Information:</h3>
               <p><strong>Instance ID:</strong> <span id="instance-id">Loading...</span></p>
               <p><strong>Availability Zone:</strong> <span id="az">Loading...</span></p>
               <p><strong>Instance Type:</strong> <span id="instance-type">Loading...</span></p>
               <p><strong>Launch Time:</strong> <span id="launch-time">Loading...</span></p>
           </div>
           <div class="info">
               <h3>Lab Objectives Completed:</h3>
               <ul>
                   <li>✅ Launched EC2 instance</li>
                   <li>✅ Configured security groups</li>
                   <li>✅ Installed Apache web server</li>
                   <li>✅ Deployed web application</li>
                   <li>✅ Configured firewall rules</li>
               </ul>
           </div>
       </div>
       
       <script>
           // Fetch instance metadata
           fetch('http://169.254.169.254/latest/meta-data/instance-id')
               .then(response => response.text())
               .then(data => document.getElementById('instance-id').textContent = data);
               
           fetch('http://169.254.169.254/latest/meta-data/placement/availability-zone')
               .then(response => response.text())
               .then(data => document.getElementById('az').textContent = data);
               
           fetch('http://169.254.169.254/latest/meta-data/instance-type')
               .then(response => response.text())
               .then(data => document.getElementById('instance-type').textContent = data);
               
           fetch('http://169.254.169.254/latest/meta-data/launch-time')
               .then(response => response.text())
               .then(data => document.getElementById('launch-time').textContent = data);
       </script>
   </body>
   </html>
   ```

2. **Set Proper Permissions**
   ```bash
   sudo chown -R apache:apache /var/www/html
   sudo chmod -R 755 /var/www/html
   ```

### Step 5: Test Your Web Server

1. **Test Locally**
   ```bash
   curl http://localhost
   ```

2. **Test from Browser**
   - Open your web browser
   - Navigate to your instance's public IP address
   - You should see your web page

### Step 6: Monitor Your Instance

1. **Check System Resources**
   ```bash
   # Check CPU usage
   top
   
   # Check memory usage
   free -h
   
   # Check disk usage
   df -h
   
   # Check network connections
   netstat -tuln
   ```

2. **Monitor Apache Logs**
   ```bash
   # Check access logs
   sudo tail -f /var/log/httpd/access_log
   
   # Check error logs
   sudo tail -f /var/log/httpd/error_log
   ```

3. **View CloudWatch Metrics**
   - Go to CloudWatch in AWS Console
   - Navigate to Metrics > EC2
   - Select your instance
   - View CPU, Network, and Disk metrics

### Step 7: Optional Enhancements

1. **Install SSL Certificate (Let's Encrypt)**
   ```bash
   # Install Certbot
   sudo yum install -y certbot python3-certbot-apache
   
   # Get SSL certificate (replace with your domain)
   sudo certbot --apache -d your-domain.com
   ```

2. **Configure Virtual Hosts**
   ```bash
   sudo nano /etc/httpd/conf.d/vhost.conf
   ```
   
   Add virtual host configuration:
   ```apache
   <VirtualHost *:80>
       ServerName your-domain.com
       DocumentRoot /var/www/html
       ErrorLog /var/log/httpd/your-domain_error.log
       CustomLog /var/log/httpd/your-domain_access.log combined
   </VirtualHost>
   ```

3. **Set Up Log Rotation**
   ```bash
   sudo nano /etc/logrotate.d/httpd
   ```
   
   Add log rotation configuration:
   ```
   /var/log/httpd/*.log {
       daily
       missingok
       rotate 52
       compress
       delaycompress
       notifempty
       create 640 root root
       postrotate
           /bin/systemctl reload httpd > /dev/null 2>/dev/null || true
       endscript
   }
   ```

## Verification Checklist

- [ ] EC2 instance is running and accessible
- [ ] Security group allows HTTP/HTTPS traffic
- [ ] Apache web server is installed and running
- [ ] Web page loads correctly in browser
- [ ] Instance metadata is displayed on the page
- [ ] CloudWatch metrics are available
- [ ] Logs are being generated
- [ ] Firewall rules are properly configured

## Troubleshooting

### Common Issues and Solutions

1. **Cannot connect via SSH**
   - Check security group rules
   - Verify key pair permissions
   - Ensure instance is running

2. **Web page not loading**
   - Check security group HTTP rule
   - Verify Apache is running
   - Check firewall configuration

3. **Permission denied errors**
   - Check file ownership and permissions
   - Ensure Apache user has access

4. **High CPU usage**
   - Monitor with `top` command
   - Check for runaway processes
   - Consider upgrading instance type

## Cleanup

**Important**: Always clean up resources to avoid charges!

1. **Terminate EC2 Instance**
   - Go to EC2 console
   - Select your instance
   - Click "Instance State" > "Terminate"
   - Confirm termination

2. **Delete Security Group**
   - Go to Security Groups
   - Select your custom security group
   - Click "Delete Security Group"

3. **Verify Cleanup**
   - Check that no resources are running
   - Review your AWS bill

## Cost Analysis

**Estimated costs for this lab:**
- EC2 t2.micro: $0.0116/hour (Free tier: 750 hours/month)
- EBS storage: $0.10/GB/month (Free tier: 30 GB)
- Data transfer: $0.09/GB (Free tier: 1 GB/month)

**Total estimated cost: $0.50** (if not using free tier)

## Lab Summary

In this lab, you've successfully:

1. **Launched an EC2 instance** with proper configuration
2. **Set up a web server** using Apache
3. **Configured security groups** for web traffic
4. **Deployed a web application** with dynamic content
5. **Monitored instance performance** using various tools
6. **Applied security best practices** for web servers

## Next Steps

- Explore load balancing with Application Load Balancer
- Learn about Auto Scaling Groups
- Implement SSL/TLS certificates
- Set up monitoring and alerting
- Explore containerization with Docker

## Additional Resources

- [AWS EC2 Documentation](https://docs.aws.amazon.com/ec2/)
- [Apache HTTP Server Documentation](https://httpd.apache.org/docs/)
- [AWS Security Groups Best Practices](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/working-with-security-groups.html)

---

**Instructor Notes:**
- Emphasize the importance of security group configuration
- Show students how to monitor costs in real-time
- Demonstrate both command-line and console approaches
- Address common permission and connectivity issues

**Potential Difficulties:**
- Students may struggle with SSH key permissions
- Understanding security group rules can be challenging
- Cost implications may not be immediately clear

**Assessment Points:**
- Can students successfully launch and configure an EC2 instance?
- Do they understand the purpose and configuration of security groups?
- Can they deploy and access a web application?
- Do they understand basic monitoring and troubleshooting techniques?
