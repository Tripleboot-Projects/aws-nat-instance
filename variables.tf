variable "resource_names" {
  type        = string
  description = "prefix added to all nat instance resources"
  default     = "tpb"
}

variable "vpc_id" {
  description = "The VPC ID"
  type        = string
}

variable "subnet_id" {
  description = "The subnet ID where the nat instance will be deployed"
  type        = string

}
variable "subnet_cidr_blocks" {
  description = "The CIDR blocks for the subnets"
  type        = list(string)
  validation {
    condition     = length(var.subnet_cidr_blocks) > 0
    error_message = "At least one subnet CIDR block must be provided."
  }
}

variable "route_tables_ids" {
  description = "The route tables for the nat instance to be associated with"
  type        = list(string)
  validation {
    condition     = length(var.route_tables_ids) > 0
    error_message = "At least one route table must be provided."
  }

}

variable "iam_instance_profile" {
  description = "The IAM instance profile"
  type        = string
  default     = null
}

variable "ami_id" {
  description = "The AMI ID for the nat instance"
  type        = string
  default     = "ami-034a68cada93af97e"
}

variable "instance_type" {
  description = "The instance type for the nat instance"
  type        = string
  default     = "t4g.micro"
}
