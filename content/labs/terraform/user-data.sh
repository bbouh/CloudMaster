#!/bin/bash

# CloudMaster Lab - Web Server Setup Script
# This script configures a web server on Amazon Linux 2

# Set variables
SERVER_NAME="${server_name}"
LOG_FILE="/var/log/web-server-setup.log"

# Function to log messages
log_message() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" | tee -a $LOG_FILE
}

log_message "Starting web server setup for $SERVER_NAME"

# Update system
log_message "Updating system packages"
yum update -y

# Install required packages
log_message "Installing required packages"
yum install -y httpd php php-mysqlnd php-fpm php-json php-devel php-mbstring php-xml php-gd php-pear php-cli php-common php-process php-zts php-bcmath php-dba php-dbg php-embedded php-enchant php-gmp php-intl php-ldap php-odbc php-pdo php-pdo-dblib php-pgsql php-pspell php-recode php-snmp php-soap php-tidy php-xmlrpc

# Start and enable Apache
log_message "Starting and enabling Apache web server"
systemctl start httpd
systemctl enable httpd

# Configure firewall
log_message "Configuring firewall"
systemctl start firewalld
systemctl enable firewalld
firewall-cmd --permanent --add-service=http
firewall-cmd --permanent --add-service=https
firewall-cmd --reload

# Create web content directory
log_message "Creating web content directory"
mkdir -p /var/www/html/cloudmaster

# Create main index page
log_message "Creating main index page"
cat > /var/www/html/index.html << 'EOF'
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CloudMaster Lab - Web Server</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
        }
        
        .container {
            background: rgba(255, 255, 255, 0.1);
            padding: 40px;
            border-radius: 20px;
            backdrop-filter: blur(10px);
            box-shadow: 0 8px 32px 0 rgba(31, 38, 135, 0.37);
            border: 1px solid rgba(255, 255, 255, 0.18);
            max-width: 800px;
            width: 90%;
            text-align: center;
        }
        
        h1 {
            font-size: 2.5em;
            margin-bottom: 20px;
            background: linear-gradient(45deg, #fff, #f0f0f0);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }
        
        .success {
            background: rgba(76, 175, 80, 0.2);
            padding: 20px;
            border-radius: 10px;
            margin: 20px 0;
            border-left: 4px solid #4CAF50;
        }
        
        .info-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin: 30px 0;
        }
        
        .info-card {
            background: rgba(255, 255, 255, 0.1);
            padding: 20px;
            border-radius: 10px;
            text-align: left;
        }
        
        .info-card h3 {
            color: #4CAF50;
            margin-bottom: 10px;
        }
        
        .info-card p {
            margin: 5px 0;
        }
        
        .status {
            display: inline-block;
            padding: 5px 15px;
            border-radius: 20px;
            font-size: 0.9em;
            font-weight: bold;
        }
        
        .status.running {
            background: rgba(76, 175, 80, 0.3);
            color: #4CAF50;
        }
        
        .objectives {
            background: rgba(255, 255, 255, 0.1);
            padding: 20px;
            border-radius: 10px;
            margin: 20px 0;
            text-align: left;
        }
        
        .objectives h3 {
            color: #4CAF50;
            margin-bottom: 15px;
        }
        
        .objectives ul {
            list-style: none;
            padding: 0;
        }
        
        .objectives li {
            padding: 8px 0;
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
        }
        
        .objectives li:last-child {
            border-bottom: none;
        }
        
        .objectives li::before {
            content: "✅ ";
            margin-right: 10px;
        }
        
        .footer {
            margin-top: 30px;
            padding-top: 20px;
            border-top: 1px solid rgba(255, 255, 255, 0.2);
            font-size: 0.9em;
            opacity: 0.8;
        }
        
        @media (max-width: 768px) {
            .container {
                padding: 20px;
            }
            
            h1 {
                font-size: 2em;
            }
            
            .info-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>🚀 CloudMaster Lab - Web Server</h1>
        
        <div class="success">
            <h2>Congratulations!</h2>
            <p>Your web server is running successfully on AWS EC2!</p>
            <span class="status running">● RUNNING</span>
        </div>
        
        <div class="info-grid">
            <div class="info-card">
                <h3>🖥️ Server Information</h3>
                <p><strong>Instance ID:</strong> <span id="instance-id">Loading...</span></p>
                <p><strong>Instance Type:</strong> <span id="instance-type">Loading...</span></p>
                <p><strong>Availability Zone:</strong> <span id="az">Loading...</span></p>
                <p><strong>Launch Time:</strong> <span id="launch-time">Loading...</span></p>
            </div>
            
            <div class="info-card">
                <h3>🌐 Network Information</h3>
                <p><strong>Public IP:</strong> <span id="public-ip">Loading...</span></p>
                <p><strong>Private IP:</strong> <span id="private-ip">Loading...</span></p>
                <p><strong>VPC ID:</strong> <span id="vpc-id">Loading...</span></p>
                <p><strong>Subnet ID:</strong> <span id="subnet-id">Loading...</span></p>
            </div>
        </div>
        
        <div class="objectives">
            <h3>🎯 Lab Objectives Completed</h3>
            <ul>
                <li>Launched EC2 instance with Terraform</li>
                <li>Configured VPC and networking</li>
                <li>Set up security groups</li>
                <li>Installed and configured Apache web server</li>
                <li>Deployed web application</li>
                <li>Configured firewall rules</li>
                <li>Set up monitoring and logging</li>
            </ul>
        </div>
        
        <div class="footer">
            <p>This server was deployed using Terraform as part of the CloudMaster learning platform.</p>
            <p>Remember to clean up your resources when done with the lab!</p>
        </div>
    </div>
    
    <script>
        // Fetch instance metadata
        async function fetchMetadata() {
            try {
                const instanceId = await fetch('http://169.254.169.254/latest/meta-data/instance-id').then(r => r.text());
                const instanceType = await fetch('http://169.254.169.254/latest/meta-data/instance-type').then(r => r.text());
                const az = await fetch('http://169.254.169.254/latest/meta-data/placement/availability-zone').then(r => r.text());
                const launchTime = await fetch('http://169.254.169.254/latest/meta-data/launch-time').then(r => r.text());
                const publicIp = await fetch('http://169.254.169.254/latest/meta-data/public-ipv4').then(r => r.text());
                const privateIp = await fetch('http://169.254.169.254/latest/meta-data/local-ipv4').then(r => r.text());
                const vpcId = await fetch('http://169.254.169.254/latest/meta-data/network/interfaces/macs/$(curl -s http://169.254.169.254/latest/meta-data/network/interfaces/macs/)/vpc-id').then(r => r.text());
                const subnetId = await fetch('http://169.254.169.254/latest/meta-data/network/interfaces/macs/$(curl -s http://169.254.169.254/latest/meta-data/network/interfaces/macs/)/subnet-id').then(r => r.text());
                
                document.getElementById('instance-id').textContent = instanceId;
                document.getElementById('instance-type').textContent = instanceType;
                document.getElementById('az').textContent = az;
                document.getElementById('launch-time').textContent = new Date(launchTime).toLocaleString();
                document.getElementById('public-ip').textContent = publicIp;
                document.getElementById('private-ip').textContent = privateIp;
                document.getElementById('vpc-id').textContent = vpcId;
                document.getElementById('subnet-id').textContent = subnetId;
            } catch (error) {
                console.error('Error fetching metadata:', error);
                // Fallback values
                document.getElementById('instance-id').textContent = 'Not available';
                document.getElementById('instance-type').textContent = 'Not available';
                document.getElementById('az').textContent = 'Not available';
                document.getElementById('launch-time').textContent = 'Not available';
                document.getElementById('public-ip').textContent = 'Not available';
                document.getElementById('private-ip').textContent = 'Not available';
                document.getElementById('vpc-id').textContent = 'Not available';
                document.getElementById('subnet-id').textContent = 'Not available';
            }
        }
        
        // Load metadata when page loads
        fetchMetadata();
        
        // Refresh metadata every 30 seconds
        setInterval(fetchMetadata, 30000);
    </script>
</body>
</html>
EOF

# Create a simple PHP info page
log_message "Creating PHP info page"
cat > /var/www/html/phpinfo.php << 'EOF'
<?php
// Simple PHP info page for CloudMaster Lab
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>PHP Information - CloudMaster Lab</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            background-color: #f5f5f5;
        }
        .container {
            max-width: 1200px;
            margin: 0 auto;
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        h1 {
            color: #333;
            text-align: center;
            margin-bottom: 30px;
        }
        .info-box {
            background: #e8f4f8;
            padding: 15px;
            border-radius: 5px;
            margin: 20px 0;
            border-left: 4px solid #2196F3;
        }
        .info-box h3 {
            margin-top: 0;
            color: #1976D2;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>🐘 PHP Information - CloudMaster Lab</h1>
        
        <div class="info-box">
            <h3>Server Information</h3>
            <p><strong>Server Software:</strong> <?php echo $_SERVER['SERVER_SOFTWARE']; ?></p>
            <p><strong>Document Root:</strong> <?php echo $_SERVER['DOCUMENT_ROOT']; ?></p>
            <p><strong>Server Name:</strong> <?php echo $_SERVER['SERVER_NAME']; ?></p>
            <p><strong>Server Port:</strong> <?php echo $_SERVER['SERVER_PORT']; ?></p>
        </div>
        
        <div class="info-box">
            <h3>PHP Configuration</h3>
            <p><strong>PHP Version:</strong> <?php echo phpversion(); ?></p>
            <p><strong>PHP SAPI:</strong> <?php echo php_sapi_name(); ?></p>
            <p><strong>Loaded Extensions:</strong> <?php echo implode(', ', get_loaded_extensions()); ?></p>
        </div>
        
        <div class="info-box">
            <h3>System Information</h3>
            <p><strong>Operating System:</strong> <?php echo php_uname(); ?></p>
            <p><strong>Architecture:</strong> <?php echo php_uname('m'); ?></p>
            <p><strong>Hostname:</strong> <?php echo php_uname('n'); ?></p>
        </div>
        
        <p><a href="/">← Back to Main Page</a></p>
    </div>
</body>
</html>
EOF

# Set proper permissions
log_message "Setting proper permissions"
chown -R apache:apache /var/www/html
chmod -R 755 /var/www/html

# Create a simple monitoring script
log_message "Creating monitoring script"
cat > /usr/local/bin/cloudmaster-monitor.sh << 'EOF'
#!/bin/bash

# CloudMaster Lab Monitoring Script
LOG_FILE="/var/log/cloudmaster-monitor.log"

log_message() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" >> $LOG_FILE
}

# Check Apache status
if systemctl is-active --quiet httpd; then
    log_message "Apache is running"
else
    log_message "Apache is not running - attempting to start"
    systemctl start httpd
fi

# Check disk usage
DISK_USAGE=$(df / | awk 'NR==2 {print $5}' | sed 's/%//')
if [ $DISK_USAGE -gt 80 ]; then
    log_message "WARNING: Disk usage is ${DISK_USAGE}%"
fi

# Check memory usage
MEMORY_USAGE=$(free | awk 'NR==2{printf "%.2f", $3*100/$2}')
if (( $(echo "$MEMORY_USAGE > 80" | bc -l) )); then
    log_message "WARNING: Memory usage is ${MEMORY_USAGE}%"
fi

# Check load average
LOAD_AVG=$(uptime | awk -F'load average:' '{print $2}' | awk '{print $1}' | sed 's/,//')
if (( $(echo "$LOAD_AVG > 2" | bc -l) )); then
    log_message "WARNING: Load average is ${LOAD_AVG}"
fi
EOF

chmod +x /usr/local/bin/cloudmaster-monitor.sh

# Set up log rotation
log_message "Setting up log rotation"
cat > /etc/logrotate.d/cloudmaster << 'EOF'
/var/log/cloudmaster-monitor.log {
    daily
    missingok
    rotate 7
    compress
    delaycompress
    notifempty
    create 644 root root
}
EOF

# Create a cron job for monitoring
log_message "Setting up monitoring cron job"
echo "*/5 * * * * /usr/local/bin/cloudmaster-monitor.sh" | crontab -

# Install CloudWatch agent (optional)
log_message "Installing CloudWatch agent"
yum install -y amazon-cloudwatch-agent

# Create CloudWatch agent configuration
cat > /opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json << 'EOF'
{
    "metrics": {
        "namespace": "CloudMaster/Lab",
        "metrics_collected": {
            "cpu": {
                "measurement": ["cpu_usage_idle", "cpu_usage_iowait", "cpu_usage_user", "cpu_usage_system"],
                "metrics_collection_interval": 60
            },
            "disk": {
                "measurement": ["used_percent"],
                "metrics_collection_interval": 60,
                "resources": ["*"]
            },
            "mem": {
                "measurement": ["mem_used_percent"],
                "metrics_collection_interval": 60
            }
        }
    },
    "logs": {
        "logs_collected": {
            "files": {
                "collect_list": [
                    {
                        "file_path": "/var/log/httpd/access_log",
                        "log_group_name": "CloudMaster/WebServer/Access",
                        "log_stream_name": "{instance_id}"
                    },
                    {
                        "file_path": "/var/log/httpd/error_log",
                        "log_group_name": "CloudMaster/WebServer/Error",
                        "log_stream_name": "{instance_id}"
                    }
                ]
            }
        }
    }
}
EOF

# Start CloudWatch agent
/opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -a fetch-config -m ec2 -c file:/opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json -s

# Final system check
log_message "Performing final system check"
systemctl status httpd >> $LOG_FILE 2>&1
systemctl status firewalld >> $LOG_FILE 2>&1

# Create a simple health check endpoint
log_message "Creating health check endpoint"
cat > /var/www/html/health.php << 'EOF'
<?php
header('Content-Type: application/json');

$health = [
    'status' => 'healthy',
    'timestamp' => date('c'),
    'services' => [
        'apache' => 'running',
        'php' => 'running',
        'disk' => disk_free_space('/') > 1000000000 ? 'ok' : 'warning',
        'memory' => 'ok'
    ],
    'uptime' => shell_exec('uptime -p'),
    'load_average' => sys_getloadavg()
];

echo json_encode($health, JSON_PRETTY_PRINT);
?>
EOF

log_message "Web server setup completed successfully!"
log_message "Server is ready to serve web content"

# Send notification (if SNS topic is configured)
if [ ! -z "$SNS_TOPIC_ARN" ]; then
    aws sns publish --topic-arn "$SNS_TOPIC_ARN" --message "CloudMaster Lab web server setup completed successfully on instance $(curl -s http://169.254.169.254/latest/meta-data/instance-id)" --subject "CloudMaster Lab - Server Ready"
fi

log_message "Setup script execution completed"
