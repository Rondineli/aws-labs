output "aws_vpc" {
  value = aws_vpc.main.id
}

output "aws_subnet" {
  value = aws_subnet.main_subnets.*.id
}
