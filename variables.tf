variable "aws_region" {
  description = "AWS region where resources will be created"
  type        = string
  default     = "us-east-1"
}

variable "instance_type" {
  description = "EC2 instance type (fallback if free-tier not available)"
  type        = string
  default     = "t3.micro"
}
