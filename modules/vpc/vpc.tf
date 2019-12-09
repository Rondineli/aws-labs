resource "aws_vpc" "main" {
  cidr_block       = var.default_cidr
  enable_dns_hostnames = var.enable_dns_hostnames

  tags = {
    Name = "${var.module_name}_main_vpc"
  }
}
