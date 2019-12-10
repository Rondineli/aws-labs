locals {
  stack_name   = "aws_lab_flask_app_stack"
  region       = var.region
}

resource "aws_opsworks_stack" "flask_app_stack" {
  name                         = local.stack_name

  default_ssh_key_name          = var.ssh_key_name
  default_root_device_type      = "ebs"


  region                       = local.region
  default_availability_zone    = "${local.region}b"
  color                        = "rgb(186, 65, 50)"
  service_role_arn             = aws_iam_role.aws-opsworks-service-role-ire.arn
  default_instance_profile_arn = aws_iam_instance_profile.opsworks_instance.arn
  default_os                   = "Ubuntu 18.04 LTS"
  vpc_id                       = module.networks.aws_vpc
  default_subnet_id            = element(module.networks.aws_subnet, 1)

  # Chef
  configuration_manager_name    = "Chef"
  configuration_manager_version = "12"
  manage_berkshelf              = true
  use_custom_cookbooks          = true

  custom_json =  file("${path.module}/custom_json/custom_json.json")

  custom_cookbooks_source {
    type    = "s3"
    url     = "https://aws-labs-opsworks-cookbooks.s3-us-west-2.amazonaws.com/cookbooks.tar.gz"
  }
}

resource "aws_opsworks_custom_layer" "custlayer" {
  name       = "My Awesome Custom Layer"
  short_name = "flask_app_custom_layer"
  stack_id   = aws_opsworks_stack.flask_app_stack.id
  auto_assign_public_ips       = true
  auto_assign_elastic_ips      = true
  elastic_load_balancer = aws_elb.opsworks-flask-app-elb.name
  drain_elb_on_shutdown = true

  custom_configure_recipes = ["flask_app::master"]
  custom_deploy_recipes = ["flask_app::master"]
  custom_setup_recipes = ["flask_app::master"] 

}

resource "aws_opsworks_instance" "my-instance" {
  stack_id = aws_opsworks_stack.flask_app_stack.id

  layer_ids = [aws_opsworks_custom_layer.custlayer.id,]
  instance_type = "t2.micro"
  os            = "Ubuntu 18.04 LTS"
  state         = "stopped"
}

resource "aws_opsworks_application" "my_app" {
  name        = "FlaskApp"
  short_name  = "flaskapp"
  stack_id    = aws_opsworks_stack.flask_app_stack.id
  type        = "other"
  description = "This is a Flask application"

  environment {
    key    = "key"
    value  = "value"
    secure = false
  }

  app_source {
    type     = "git"
    revision = "master"
    url      = "https://github.com/Rondineli/opsworks-recipes.git"
  }

  enable_ssl = false

  # document_root         = "public"
  # auto_bundle_on_deploy = true
  # rails_env             = "staging"
}
