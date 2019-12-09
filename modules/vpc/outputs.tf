output "aws_vpc" {
  value = aws_vpc.main.vpc_id
}

output "aws_subnet" {
  value = aws_subnet.main_subnets.*.id
}
