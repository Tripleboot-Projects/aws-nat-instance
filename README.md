



## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.66 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.87.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_instance_profile.nat_instance_profile](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile) | resource |
| [aws_iam_role.nat_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.nat_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_instance.nat_instance](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_route.nat_route](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_security_group.nat_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.all_egress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.nat_ingress_http](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.nat_ingress_https](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ami_id"></a> [ami\_id](#input\_ami\_id) | The AMI ID for the nat instance | `string` | `"ami-034a68cada93af97e"` | no |
| <a name="input_iam_instance_profile"></a> [iam\_instance\_profile](#input\_iam\_instance\_profile) | The IAM instance profile | `string` | `null` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | The instance type for the nat instance | `string` | `"t4g.micro"` | no |
| <a name="input_resource_names"></a> [resource\_names](#input\_resource\_names) | prefix added to all nat instance resources | `string` | `"tpb"` | no |
| <a name="input_route_tables_ids"></a> [route\_tables\_ids](#input\_route\_tables\_ids) | The route tables for the nat instance to be associated with | `list(string)` | n/a | yes |
| <a name="input_subnet_cidr_blocks"></a> [subnet\_cidr\_blocks](#input\_subnet\_cidr\_blocks) | The CIDR blocks for the subnets | `list(string)` | n/a | yes |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | The subnet ID where the nat instance will be deployed | `string` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The VPC ID | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_nat_instance_availability_zone"></a> [nat\_instance\_availability\_zone](#output\_nat\_instance\_availability\_zone) | The availability zone of the NAT instance |
| <a name="output_nat_instance_id"></a> [nat\_instance\_id](#output\_nat\_instance\_id) | The ID of the NAT instance |
| <a name="output_nat_instance_private_ip"></a> [nat\_instance\_private\_ip](#output\_nat\_instance\_private\_ip) | The private IP address of the NAT instance |
| <a name="output_nat_instance_profile_arn"></a> [nat\_instance\_profile\_arn](#output\_nat\_instance\_profile\_arn) | The IAM instance profile arn |
| <a name="output_nat_instance_public_ip"></a> [nat\_instance\_public\_ip](#output\_nat\_instance\_public\_ip) | The public IP address of the NAT instance |
| <a name="output_nat_instance_role_arn"></a> [nat\_instance\_role\_arn](#output\_nat\_instance\_role\_arn) | The IAM instance role arn |
| <a name="output_nat_instance_subnet_id"></a> [nat\_instance\_subnet\_id](#output\_nat\_instance\_subnet\_id) | The subnet ID where the NAT instance is deployed |
| <a name="output_nat_security_group_id"></a> [nat\_security\_group\_id](#output\_nat\_security\_group\_id) | The ID of the NAT security group |
| <a name="output_routes_ids"></a> [routes\_ids](#output\_routes\_ids) | The route tables for the nat instance to be associated with |
