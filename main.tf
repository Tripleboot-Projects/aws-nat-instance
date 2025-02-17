resource "aws_security_group" "nat_sg" {
  name        = "${var.resource_names}-nat-instance"
  description = "Allow inbound traffic for NAT instance inside the VPC"
  vpc_id      = var.vpc_id
}

resource "aws_security_group_rule" "nat_ingress_http" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = var.subnet_cidr_blocks
  security_group_id = aws_security_group.nat_sg.id
}

resource "aws_security_group_rule" "nat_ingress_https" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = var.subnet_cidr_blocks
  security_group_id = aws_security_group.nat_sg.id
}

resource "aws_security_group_rule" "all_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
  security_group_id = aws_security_group.nat_sg.id
}

resource "aws_iam_role" "nat_role" {
  count = var.iam_instance_profile == null ? 1 : 0
  name  = "${var.resource_names}-instance-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}
resource "aws_iam_instance_profile" "nat_instance_profile" {
  count = var.iam_instance_profile == null ? 1 : 0
  name  = "${var.resource_names}-nat-instance-profile"
  role  = aws_iam_role.nat_role[0].name
}
resource "aws_iam_role_policy_attachment" "nat_policy_attachment" {
  count      = var.iam_instance_profile == null ? 1 : 0
  role       = aws_iam_role.nat_role[0].name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_instance" "nat_instance" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  associate_public_ip_address = true
  source_dest_check           = false
  security_groups             = [aws_security_group.nat_sg.id]
  iam_instance_profile        = var.iam_instance_profile == null ? aws_iam_instance_profile.nat_instance_profile[0].name : var.iam_instance_profile
  metadata_options {
    http_endpoint               = "enabled"
    http_put_response_hop_limit = "1"
    http_tokens                 = "required"
  }
  user_data = <<-EOF
#!/bin/bash
sudo yum install iptables-services -y
sudo systemctl enable iptables
sudo systemctl start iptables
echo 'net.ipv4.ip_forward = 1' > /etc/sysctl.d/custom-ip-forwarding.conf
sudo sysctl -p /etc/sysctl.d/custom-ip-forwarding.conf
MAIN_INTERFACE=$(route | grep '^default' | grep -o '[^ ]*$')
sudo iptables -t nat -A POSTROUTING -o $MAIN_INTERFACE -j MASQUERADE
sudo iptables -F FORWARD
sudo service iptables save
EOF
  tags = {
    Name = "${var.resource_names}-nat-instance"
  }
  #   lifecycle {
  #     ignore_changes = [
  #       # Ignora cambios en los atributos que no afectan el comportamiento
  #       user_data,
  #       security_groups,
  #       metadata_options,
  #       # Puedes agregar otros atributos que sean inestables
  #     ]
  #   }
}
resource "aws_route" "nat_route" {
  for_each               = toset(var.route_tables_ids)
  route_table_id         = each.value
  destination_cidr_block = "0.0.0.0/0"
  network_interface_id   = aws_instance.nat_instance.primary_network_interface_id
}
