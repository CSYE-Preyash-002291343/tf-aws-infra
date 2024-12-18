resource "aws_subnet" "public" {
  count = length(local.AZ)

  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet(aws_vpc.main.cidr_block, 8, count.index)
  availability_zone = local.AZ[count.index]

  map_public_ip_on_launch = true

  tags = {
    Name = "publicSubnet_${count.index + 1}-${var.environment}"
  }
}

resource "aws_subnet" "private" {
  count = length(local.AZ)

  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet(aws_vpc.main.cidr_block, 8, count.index + 3)
  availability_zone = local.AZ[count.index]

  map_public_ip_on_launch = false

  tags = {
    Name = "privateSubnet_${count.index + 1}-${var.environment}"
  }
}