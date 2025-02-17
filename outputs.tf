output "nat_security_group_id" {
  description = "The ID of the NAT security group"
  value       = aws_security_group.nat_sg.id
}

output "nat_instance_profile_arn" {
  description = "The IAM instance profile arn"
  value       = try(aws_iam_instance_profile.nat_instance_profile[0].arn, null)
}
output "nat_instance_role_arn" {
  description = "The IAM instance role arn"
  value       = try(aws_iam_role.nat_role[0].arn, null)

}

output "nat_instance_id" {
  description = "The ID of the NAT instance"
  value       = aws_instance.nat_instance.id
}

output "nat_instance_private_ip" {
  description = "The private IP address of the NAT instance"
  value       = aws_instance.nat_instance.private_ip
}

output "nat_instance_public_ip" {
  description = "The public IP address of the NAT instance"
  value       = aws_instance.nat_instance.public_ip
}

output "nat_instance_availability_zone" {
  description = "The availability zone of the NAT instance"
  value       = aws_instance.nat_instance.availability_zone
}

output "nat_instance_subnet_id" {
  description = "The subnet ID where the NAT instance is deployed"
  value       = aws_instance.nat_instance.subnet_id
}

# output "routes_ids" {
#   description = "The route tables for the nat instance to be associated with"
#   value       = aws_route.nat_route[*].route_table_id
# }
