output "instance_type_used" {
  description = "Instance type used for the EC2 instances"
  value       = local.instance_type
}

output "security_group_id" {
  description = "ID of the default security group used"
  value       = data.aws_security_group.default.id
}

output "server_1_public_ip" {
  description = "Public IP address of server-1"
  value       = aws_instance.server_1.public_ip
}

output "server_2_public_ip" {
  description = "Public IP address of server-2"
  value       = aws_instance.server_2.public_ip
}

output "server_3_public_ip" {
  description = "Public IP address of server-3"
  value       = aws_instance.server_3.public_ip
}

output "server_1_private_ip" {
  description = "Private IP address of server-1"
  value       = aws_instance.server_1.private_ip
}

output "server_2_private_ip" {
  description = "Private IP address of server-2"
  value       = aws_instance.server_2.private_ip
}

output "server_3_private_ip" {
  description = "Private IP address of server-3"
  value       = aws_instance.server_3.private_ip
}

output "security_group_id" {
  description = "ID of the default security group used"
  value       = data.aws_security_group.default.id
}
