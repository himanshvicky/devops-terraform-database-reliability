
variable "aws_region" {
  description = "AWS region for infrastructure"
  type        = string
  default     = "ap-south-1"
}

variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = "dev"
}

variable "project_name" {
  description = "Project name"
  type        = string
  default     = "database-reliability"
}

variable "db_name" {
  description = "PostgreSQL database name"
  type        = string
  default     = "bookings"
}

variable "db_username" {
  description = "Database username"
  type        = string
  default     = "assessment"
}

variable "db_instance_class" {
  description = "RDS instance type"
  type        = string
  default     = "db.t3.micro"
}

variable "db_allocated_storage" {
  description = "Database storage in GB"
  type        = number
  default     = 20
}

variable "vpc_cidr" {
  description = "CIDR range for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "db_allowed_cidr" {
  description = "Trusted client IP range allowed to access PostgreSQL"
  type        = string
}

variable "db_password" {
  description = "PostgreSQL database password"
  type        = string
  sensitive   = true
}
