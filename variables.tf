variable "aws_region" {
  description = "AWS region to deploy resources in"
  type        = string
  default     = "ap-south-1"
}

variable "name" {
  description = "Name prefix for resources"
  type        = string
  default     = "mongodb-demo"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "key_name" {
  description = "Name of the EC2 key pair to create"
  type        = string
  default     = "mongodb-demo-key"
}

variable "public_key_path" {
  description = "Path to your public SSH key (used to create the key pair)"
  type        = string
  default     = "~/.ssh/id_rsa.pub"
}

variable "allowed_ssh_cidr" {
  description = "CIDR block allowed to SSH into the instance (lock this down)"
  type        = string
  default     = "0.0.0.0/0"
}

variable "allowed_mongo_cidr" {
  description = "CIDR block allowed access to MongoDB port (lock this down)"
  type        = string
  default     = "0.0.0.0/0"
}

variable "mongo_port" {
  description = "Port MongoDB will listen on"
  type        = number
  default     = 27017
}
