variable "environment_name" {
  description = "The name of the environment"
}

variable "aws_region" {
  description = "AWS region to create the VPC and services"
}

variable "aws_profile" {
  description = "AWS profile to use other than the default"
  default     = "default"
}

variable "aws_security_group_ids" {
  description = "AWS security group ID's that the brokers will be bound to"
  type        = "list"
}

variable "aws_subnet_ids" {
  description = "AWS subnet ID's that the brokers will be bound to"
  type        = "list"
}

variable "aws_instance_type" {
  description = "The EC2 instance type"
  default     = "mq.t2.micro"
}

variable "aws_mq_username" {
  description = "The Amazon MQ broker admin username"
}

variable "aws_mq_password" {
  description = "The Amazon MQ broker admin password"
}
