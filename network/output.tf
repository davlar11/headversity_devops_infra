output "public_sg_id" {
  value = aws_security_group.saas_public_sg.id
}

output "public_subnet_ids" {
  value = aws_subnet.saas_public_subnet.*.id
}

output "vpc_id" {
  value = aws_vpc.saas_vpc.id
}