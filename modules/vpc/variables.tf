variable "default_cidr" {
	default = "10.0.0.0/16"
}

variable "enable_dns_hostnames" {
	default = true
}

variable "region_number" {
  default = {
    "0" = "a"
    "1" = "b"
    "2" = "c"
  }
}

variable "module_name" {}