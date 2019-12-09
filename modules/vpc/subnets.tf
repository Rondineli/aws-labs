resource "aws_subnet" "main_subnets" {
  count             = 3 # Each available zone
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.${count.index}.0/24"
  availability_zone = "${var.region}${var.region_number[count.index]}"

  tags = {
    "Name" = "${var.module_name}_dubnet_${count.index}_vpc"
  }
}

resource "aws_internet_gateway" "igw_subnet" {
  vpc_id = "${aws_vpc.main.id}"

  tags {
    Name = "eks-poc"
  }
}

resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw_subnet.id
  }
}

resource "aws_route_table_association" "demo" {
  count = 3
  subnet_id      = aws_subnet.main_subnets.*.id[count.index]
  route_table_id = aws_route_table.rt.id
}
