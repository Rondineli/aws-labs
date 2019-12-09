locals {
  stack_name   = "aws_lab_flask_app_stack"
  region       = "var.region"
}



resource "aws_opsworks_stack" "flask_app_stack" {
  name                         = "local.stack_name"

  default_ssh_key_name          = "var.ssh_key_name"
  default_root_device_type      = "ebs"


  region                       = "local.region"
  default_availability_zone    = "${local.region}a"
  color                        = "red"
  
  default_instance_profile_arn = "aws_iam_instance_profile.opsworks-instance.arn"
  service_role_arn             = "aws_iam_role.opsworks-instance.arn"
  default_os                   = "Amazon Linux"
  vpc_id                       = "module.networks.aws_vpc"
  default_subnet_id            = "element(module.aws_subnet, 1)"

  # Chef
  configuration_manager_name    = "Chef"
  configuration_manager_version = "11.4"
  manage_berkshelf              = true
  use_custom_cookbooks          = true

  # Cookbooks
  custom_cookbooks_source = {
    type    = "Git"
    url     = ""
    ssh_key = ""
  }
}