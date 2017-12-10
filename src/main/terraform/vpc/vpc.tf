# Specify the provider and access details
provider "aws" {
  region                       = "${var.aws_region}"
  profile                      = "${var.aws_profile}"
}

################        VPC        ################


# Public VPC required for NAT gateways and Squid Proxies
resource "aws_vpc" "vpc_1" {
  cidr_block                   = "${var.aws_public_vpc_cidr}"
  enable_dns_support           = "true"
  enable_dns_hostnames         = "true"

  tags {
    Name                       = "${var.environment_name}_vpc_1"
  }
}

################ Internet Gateway  ################


# Internet Gateway to give our subnet access to the outside world
resource "aws_internet_gateway" "ig_1" {
  vpc_id                       = "${aws_vpc.vpc_1.id}"

  tags {
    Name                       = "${var.environment_name}_ig_1"
  }
}


################   Route Tables    ################


# Route Table for Internet access
resource "aws_route_table" "rt_1" {
  vpc_id                       = "${aws_vpc.vpc_1.id}"

  route {
    cidr_block                 = "0.0.0.0/0"
    gateway_id                 = "${aws_internet_gateway.ig_1.id}"
  }

  tags {
    Name                       = "${var.environment_name}_rt_1"
  }
}

################      Subnets      ################


# Subnet 1 in Availability Zone A for NAT gateway 1
resource "aws_subnet" "sn_1" {
  vpc_id                       = "${aws_vpc.vpc_1.id}"
  cidr_block                   = "${var.aws_sn_1_cidr}"
  availability_zone            = "${var.aws_region}a"
  map_public_ip_on_launch      = true

  tags {
    Name                       = "${var.environment_name}_sn_1"
  }
}

resource "aws_route_table_association" "rta_1" {
  subnet_id                    = "${aws_subnet.sn_1.id}"
  route_table_id               = "${aws_route_table.rt_1.id}"
}

# Subnet 2 in Availability Zone B for NAT gateway 2
resource "aws_subnet" "sn_2" {
  vpc_id                       = "${aws_vpc.vpc_1.id}"
  cidr_block                   = "${var.aws_sn_2_cidr}"
  availability_zone            = "${var.aws_region}b"
  map_public_ip_on_launch      = true

  tags {
    Name                       = "${var.environment_name}_sn_2"
  }
}

resource "aws_route_table_association" "rta_2" {
  subnet_id                    = "${aws_subnet.sn_2.id}"
  route_table_id               = "${aws_route_table.rt_1.id}"
}

################  Security Groups  ################


# Security Group for Bastion Hosts
resource "aws_security_group" "sg_1" {
  name                         = "${var.environment_name}_sg_1"
  vpc_id                       = "${aws_vpc.vpc_1.id}"

  # SSH access only from Bastion network
  ingress {
    from_port                  = 22
    to_port                    = 22
    protocol                   = "tcp"
    cidr_blocks                = ["${var.bastion_network_cidr}"]
  }

  # SSH access only from Bastion network
  ingress {
    from_port                  = "${var.amazon_mq_port}"
    to_port                    = "${var.amazon_mq_port}"
    protocol                   = "tcp"
    cidr_blocks                = ["${var.bastion_network_cidr}"]
  }

  egress {
    from_port                  = 0
    to_port                    = 0
    protocol                   = "-1"
    cidr_blocks                = ["0.0.0.0/0"]
  }

  tags {
    Name                       = "${var.environment_name}_sg_1"
  }
}
