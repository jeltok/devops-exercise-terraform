
# provider variable
variable "aws_region" {
  description = "Configuring AWS as provider"
  type        = string
  default     = "us-east-1"
}

variable "aws_access_key" {
  type      = string
  sensitive = true
}

variable "aws_secret_key" {
  type      = string
  sensitive = true
}

# vpc variable
variable "vpc_cidr" {
  description = "CIDR block for main"
  type        = string
  default     = "10.0.0.0/16"
}

# availability zones variable
variable "availability_zones" {
  type    = string
  default = "us-east-1a"
}

variable "rds_db_name" {
  type = string
  default = "testdb"
}

variable "rds_db_username" {
  type = string
  sensitive = true
}

variable "rds_db_password" {
  type      = string
  sensitive = true
}

variable "ecr_repo_uri" {
  type = string
  default = "354386841181.dkr.ecr.us-east-1.amazonaws.com/devops/node_js:latest"
}