resource "aws_vpc" "saas_vpc" {
  tags = {
    Name        = "${var.environment} VPC"
    contentType = "Infrastructure"
    Active      = "True"
  }
  cidr_block           = var.saas_vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
}
resource "aws_internet_gateway" "saas_igw" {
  tags = {
    Name        = "${var.environment} IGW"
    contentType = "Infrastructure"
    Active      = "True"
  }
  vpc_id = aws_vpc.saas_vpc.id
}

resource "aws_default_route_table" "saas_default" {
  tags = {
    Name        = "Default Route Table"
    contentType = "Infrastructure"
    Active      = "True"
  }
  default_route_table_id = aws_vpc.saas_vpc.default_route_table_id
}

#######################################
########  Public Networking  ##########
#######################################
resource "aws_route_table" "saas_public" {
  tags = {
    Name        = "${var.environment} Public RT"
    contentType = "Infrastructure"
    Active      = "True"
  }
  vpc_id = aws_vpc.saas_vpc.id
}

resource "aws_route" "saas_public_route_gateway" {
  route_table_id         = aws_route_table.saas_public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.saas_igw.id
}

resource "aws_subnet" "saas_public_subnet" {
  tags = {
    Name        = "${var.environment} Public Subnet ${count.index + 1}"
    contentType = "Infrastructure"
    Active      = "True"
  }
  count             = var.number_of_az
  vpc_id            = aws_vpc.saas_vpc.id
  availability_zone = data.aws_availability_zones.available.names[count.index]
  cidr_block        = var.saas_public_subnet_cidr[count.index]
}

resource "aws_route_table_association" "saas_rt_association_public" {
  count          = length(aws_subnet.saas_public_subnet)
  subnet_id      = aws_subnet.saas_public_subnet.*.id[count.index]
  route_table_id = aws_route_table.saas_public.id
}

#################################
######  Internet Access  ########
#################################
resource "aws_eip" "saas_nat_ip" {
  tags = {
    Name        = "${var.environment} NAT IP"
    contentType = "Infrastructure"
    Active      = "True"
  }
}

resource "aws_nat_gateway" "saas_nat" {
  tags = {
    Name        = "${var.environment} NAT"
    contentType = "Infrastructure"
    Active      = "True"
  }
  allocation_id = aws_eip.saas_nat_ip.id
  subnet_id     = aws_subnet.saas_public_subnet[0].id
}
