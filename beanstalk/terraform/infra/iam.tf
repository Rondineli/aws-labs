resource "aws_iam_instance_profile" "beanstalk_instance" {
  name  = "beanstalk_instance"
  role = aws_iam_role.aws-beanstalk-prod-ec2-role-ire.name
}

resource "aws_iam_role" "aws-beanstalk-prod-ec2-role-ire" {
  name               = "aws-beanstalk-prod-ec2-role-ire"
  path               = "/"
  assume_role_policy = file("${path.module}/policies/aws-beanstalk-prod-ec2-role-ire.json")
}

resource "aws_iam_role" "aws-beanstalk-service-role-ire" {
  name               = "aws-beanstalk-service-role-ire"
  path               = "/"
  assume_role_policy = file("${path.module}/policies/aws-beanstalk-service-role-ire.json")
}

resource "aws_iam_role_policy" "aws-service-policy-route53-ire" {
  name   = "aws-service-policy-route53-ire"
  role   = aws_iam_role.aws-beanstalk-prod-ec2-role-ire.id
  policy = file("${path.module}/policies/aws-service-policy-route53.json")
}

resource "aws_iam_role_policy" "service-policy-s3-ire" {
  name   = "service-policy-s3-ire"
  role   = aws_iam_role.aws-beanstalk-prod-ec2-role-ire.id
  policy = file("${path.module}/policies/service-policy-s3.json")
}
resource "aws_iam_role_policy" "aws-service-policies-ire" {
  name   = "aws-service-policies-ire"
  role   = aws_iam_role.aws-beanstalk-prod-ec2-role-ire.id
  policy = file("${path.module}/policies/aws-service-policies.json")
}

resource "aws_iam_role_policy" "aws-beanstalk-service-policies-ire" {
  name   = "aws-beanstalk-service-policies-ire"
  role   = aws_iam_role.aws-beanstalk-service-role-ire.id
  policy = file("${path.module}/policies/aws-beanstalk-service-role.json")
}
