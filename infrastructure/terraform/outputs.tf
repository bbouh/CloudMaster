# CloudMaster Infrastructure Outputs

output "vpc_id" {
  description = "ID of the VPC"
  value       = module.vpc.vpc_id
}

output "vpc_cidr_block" {
  description = "CIDR block of the VPC"
  value       = module.vpc.vpc_cidr_block
}

output "public_subnet_ids" {
  description = "IDs of the public subnets"
  value       = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  description = "IDs of the private subnets"
  value       = module.vpc.private_subnet_ids
}

output "database_subnet_ids" {
  description = "IDs of the database subnets"
  value       = module.vpc.database_subnet_ids
}

output "internet_gateway_id" {
  description = "ID of the Internet Gateway"
  value       = module.vpc.internet_gateway_id
}

output "nat_gateway_ids" {
  description = "IDs of the NAT Gateways"
  value       = module.vpc.nat_gateway_ids
}

output "alb_dns_name" {
  description = "DNS name of the Application Load Balancer"
  value       = module.alb.alb_dns_name
}

output "alb_zone_id" {
  description = "Zone ID of the Application Load Balancer"
  value       = module.alb.alb_zone_id
}

output "alb_arn" {
  description = "ARN of the Application Load Balancer"
  value       = module.alb.alb_arn
}

output "cloudfront_domain_name" {
  description = "Domain name of the CloudFront distribution"
  value       = module.cloudfront.cloudfront_domain_name
}

output "cloudfront_distribution_id" {
  description = "ID of the CloudFront distribution"
  value       = module.cloudfront.cloudfront_distribution_id
}

output "cloudfront_hosted_zone_id" {
  description = "Hosted zone ID of the CloudFront distribution"
  value       = module.cloudfront.cloudfront_hosted_zone_id
}

output "rds_endpoint" {
  description = "RDS instance endpoint"
  value       = module.database.rds_endpoint
  sensitive   = true
}

output "rds_port" {
  description = "RDS instance port"
  value       = module.database.rds_port
}

output "rds_db_name" {
  description = "RDS database name"
  value       = module.database.rds_db_name
}

output "rds_username" {
  description = "RDS master username"
  value       = module.database.rds_username
  sensitive   = true
}

output "redis_endpoint" {
  description = "ElastiCache Redis endpoint"
  value       = module.redis.redis_endpoint
  sensitive   = true
}

output "redis_port" {
  description = "ElastiCache Redis port"
  value       = module.redis.redis_port
}

output "ecs_cluster_name" {
  description = "Name of the ECS cluster"
  value       = module.ecs.cluster_name
}

output "ecs_cluster_arn" {
  description = "ARN of the ECS cluster"
  value       = module.ecs.cluster_arn
}

output "ecs_service_name" {
  description = "Name of the ECS service"
  value       = module.ecs.service_name
}

output "ecs_task_definition_arn" {
  description = "ARN of the ECS task definition"
  value       = module.ecs.task_definition_arn
}

output "ecr_repository_urls" {
  description = "URLs of the ECR repositories"
  value       = module.ecs.ecr_repository_urls
}

output "s3_bucket_name" {
  description = "Name of the S3 bucket"
  value       = module.storage.s3_bucket_name
}

output "s3_bucket_arn" {
  description = "ARN of the S3 bucket"
  value       = module.storage.s3_bucket_arn
}

output "s3_bucket_domain_name" {
  description = "Domain name of the S3 bucket"
  value       = module.storage.s3_bucket_domain_name
}

output "acm_certificate_arn" {
  description = "ARN of the ACM certificate"
  value       = module.acm.certificate_arn
}

output "acm_certificate_domain_name" {
  description = "Domain name of the ACM certificate"
  value       = module.acm.certificate_domain_name
}

output "cloudwatch_log_group_name" {
  description = "Name of the CloudWatch log group"
  value       = module.monitoring.cloudwatch_log_group_name
}

output "cloudwatch_log_group_arn" {
  description = "ARN of the CloudWatch log group"
  value       = module.monitoring.cloudwatch_log_group_arn
}

output "sns_topic_arn" {
  description = "ARN of the SNS topic for alerts"
  value       = module.monitoring.sns_topic_arn
}

output "iam_role_arn" {
  description = "ARN of the IAM role"
  value       = module.iam.iam_role_arn
}

output "iam_instance_profile_arn" {
  description = "ARN of the IAM instance profile"
  value       = module.iam.iam_instance_profile_arn
}

# Application URLs
output "application_url" {
  description = "URL of the application"
  value       = "https://${var.domain_name}"
}

output "api_url" {
  description = "URL of the API"
  value       = "https://${var.domain_name}/api"
}

output "admin_url" {
  description = "URL of the admin panel"
  value       = "https://${var.domain_name}/admin"
}

# Database connection string
output "database_url" {
  description = "Database connection URL"
  value       = "postgresql://${module.database.rds_username}:${module.database.rds_password}@${module.database.rds_endpoint}:${module.database.rds_port}/${module.database.rds_db_name}"
  sensitive   = true
}

# Redis connection string
output "redis_url" {
  description = "Redis connection URL"
  value       = "redis://${module.redis.redis_endpoint}:${module.redis.redis_port}"
  sensitive   = true
}

# Environment variables for deployment
output "environment_variables" {
  description = "Environment variables for the application"
  value = {
    NODE_ENV = var.environment
    DATABASE_URL = "postgresql://${module.database.rds_username}:${module.database.rds_password}@${module.database.rds_endpoint}:${module.database.rds_port}/${module.database.rds_db_name}"
    REDIS_URL = "redis://${module.redis.redis_endpoint}:${module.redis.redis_port}"
    AWS_REGION = var.aws_region
    S3_BUCKET_NAME = module.storage.s3_bucket_name
    CLOUDFRONT_DOMAIN = module.cloudfront.cloudfront_domain_name
  }
  sensitive = true
}
