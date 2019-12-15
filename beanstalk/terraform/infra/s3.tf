resource "aws_s3_bucket" "beanstalk_elb_logs" {
  bucket        = "beanstalk-eb-loadbalancer-logs"
  acl           = "private"
  force_destroy = true
  policy = file("${path.module}/policies/aws-beanstalk-elb-logs.json")
}