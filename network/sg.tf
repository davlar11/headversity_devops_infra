########################################
########  Public Subnet SG  ############
########################################

resource "aws_security_group" "saas_public_sg" {
  tags = {
    Name        = "${var.environment} Public SG"
    contentType = "Infrastructure"
    Active      = "True"
  }
  name        = "${var.environment}-Public"
  description = "Allow public access to resources"
  vpc_id      = aws_vpc.saas_vpc.id
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Public access"
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Public access"
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}