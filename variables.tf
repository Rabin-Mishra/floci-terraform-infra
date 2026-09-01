variable "vpc_cidr" {
  type        = string
  description = "CIDR block for VPC"

}

variable "vpc_name" {
  type        = string
  description = "Name tag for vpc"

}

variable "cidr_public_subnet" {
  type        = list(string)
  description = "CIDR blocks for public subnet"

}

variable "cidr_private_subnet" {
  type        = list(string)
  description = "CIDR blocks for private subnet"

}

variable "availability_zones" {
  type        = list(string)
  description = "List of availability zones to use for subnets"

}

variable "public_key" {
  type        = string
  description = "Public key for SSH access for Jenkins EC2 instance "
}

variable "ec2_ami_id" {
  type        = string
  description = "AMI ID for EC2 instance"

}


variable "db_username" {
  type        = string
  description = "Username for the RDS database"

}

variable "db_password" {
  type        = string
  description = "Password for the RDS database"
  sensitive   = true

}

variable "db_name" {
  type        = string
  description = "Name of the RDS database"

}
