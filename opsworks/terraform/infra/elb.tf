resource "aws_elb" "opsworks-flask-app-elb" {
  name = "aws-elb-opsworks-flask-app"

  listener {
    instance_port     = 5000
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 3
    unhealthy_threshold = 3
    timeout             = 30
    target              = "TCP:5000"
    interval            = 60
  }

  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

  subnets         = module.networks.aws_subnet
  security_groups = [aws_security_group.allow_http_elb.id]

  tags = {
    Name = "aws_elb_opsworks_flask_app"
  }
}
