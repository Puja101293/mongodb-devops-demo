variable "region" {
  description = "AWS region"
  default     = "ap-south-1"
}

variable "instance_type" {
  description = "EC2 instance type"
  default     = "t2.micro"
}

variable "key_name" {
  description = "my-keypair"
}

variable "allowed_ssh_cidr" {
  description = "CIDR block allowed for SSH"
  default     = "0.0.0.0/0"
}

variable "allowed_mongo_cidr" {
  description = "CIDR block allowed for MongoDB"
  default     = "0.0.0.0/0"
}
