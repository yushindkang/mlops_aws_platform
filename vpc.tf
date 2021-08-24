#
# VPC Resources
#  * VPC
#  * Subnets
#  * Internet Gateway
#  * Route Table
#

resource "aws_vpc" "mlops" {
  cidr_block = "10.0.0.0/16"

  tags = tomap({
    "Name"                                      = "terraform-eks-mlops-node",
    "kubernetes.io/cluster/${var.cluster-name}" = "shared"
  })
}

resource "aws_subnet" "mlops" {
  count = 2

  availability_zone       = data.aws_availability_zones.available.names[count.index]
  cidr_block              = "10.0.${count.index}.0/24"
  map_public_ip_on_launch = true
  vpc_id                  = aws_vpc.mlops.id

  tags = tomap({
    "Name"                                      = "terraform-eks-mlops-node",
    "kubernetes.io/cluster/${var.cluster-name}" = "shared"
  })
}

resource "aws_internet_gateway" "mlops" {
  vpc_id = aws_vpc.mlops.id

  tags = {
    Name = "terraform-eks-mlops"
  }
}

resource "aws_route_table" "mlops" {
  vpc_id = aws_vpc.mlops.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.mlops.id
  }
}

resource "aws_route_table_association" "mlops" {
  count = 2

  subnet_id      = aws_subnet.mlops.*.id[count.index]
  route_table_id = aws_route_table.mlops.id
}
