resource "aws_elastic_beanstalk_application" "aws_lab" {
  name        = "aws_lab"
  description = "Lab env for beanstalk"
}

resource "aws_elastic_beanstalk_environment" "aws_lab" {
  name                = "aws-lab-env-1"
  application         = aws_elastic_beanstalk_application.aws_lab.name
  solution_stack_name = "64bit Amazon Linux 2018.03 v2.14.0 running Docker 18.09.9-ce"
  tier = "WebServer"
  cname_prefix = "aws-lab"

  dynamic "setting" {
    for_each = var.additional_settings
    content {
      namespace = setting.value["namespace"]
      name      = setting.value["name"]
      value     = setting.value["value"]
    }
  }

  dynamic "setting" {
    for_each = var.env_vars
    content {
      namespace = "aws:elasticbeanstalk:application:environment"
      name      = setting.value["key"]
      value     = setting.value["value"]
    }
  }

  setting {
    namespace = "aws:ec2:vpc"
    name      = "VPCId"
    value     = module.networks.aws_vpc
  }

  setting {
    namespace = "aws:ec2:vpc"
    name      = "AssociatePublicIpAddress"
    value     = var.associate_public_ip_address
  }

  setting {
    namespace = "aws:ec2:vpc"
    name      = "Subnets"
    value     = join(",", module.networks.aws_subnet)
  }

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "SecurityGroups"
    value     = aws_security_group.allow_http_instance.id
  }

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "IamInstanceProfile"
    value     = aws_iam_instance_profile.beanstalk_instance.name
  }

  setting {
    namespace = "aws:autoscaling:asg"
    name      = "Availability Zones"
    value     = var.availability_zone_selector
  }

  setting {
    namespace = "aws:elasticbeanstalk:environment"
    name      = "EnvironmentType"
    value     = var.environment_type
  }

  setting {
    namespace = "aws:elasticbeanstalk:environment"
    name      = "ServiceRole"
    value     = aws_iam_role.aws-beanstalk-service-role-ire.name
  }

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "BASE_HOST"
    value     = var.name
  }

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "PARAM1"
    value     = var.hostname
  }

  setting {
    namespace = "aws:elasticbeanstalk:healthreporting:system"
    name      = "SystemType"
    value     = "basic"
  }

  setting {
    namespace = "aws:elasticbeanstalk:managedactions"
    name      = "ManagedActionsEnabled"
    value     = false
  }

  setting {
    namespace = "aws:autoscaling:asg"
    name      = "MinSize"
    value     = var.autoscale_min
  }

  setting {
    namespace = "aws:autoscaling:asg"
    name      = "MaxSize"
    value     = var.autoscale_max
  }

  setting {
    namespace = "aws:autoscaling:updatepolicy:rollingupdate"
    name      = "RollingUpdateEnabled"
    value     = true
  }

  setting {
    namespace = "aws:autoscaling:updatepolicy:rollingupdate"
    name      = "RollingUpdateType"
    value     = "Health"
  }

  setting {
    namespace = "aws:autoscaling:updatepolicy:rollingupdate"
    name      = "MinInstancesInService"
    value     = var.updating_min_in_service
  }

  setting {
    namespace = "aws:autoscaling:updatepolicy:rollingupdate"
    name      = "MaxBatchSize"
    value     = var.updating_max_batch
  }

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "InstanceType"
    value     = var.instance_type
  }

  setting {
    namespace = "aws:elasticbeanstalk:command"
    name      = "BatchSizeType"
    value     = "Fixed"
  }

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "EC2KeyName"
    value     = var.ssh_key_name
  }

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "RootVolumeSize"
    value     = var.root_volume_size
  }

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "RootVolumeType"
    value     = var.root_volume_type
  }

  setting {
    namespace = "aws:elasticbeanstalk:command"
    name      = "BatchSize"
    value     = "1"
  }

  setting {
    namespace = "aws:elasticbeanstalk:managedactions:platformupdate"
    name      = "InstanceRefreshEnabled"
    value     = var.instance_refresh_enabled
  }

  setting {
    namespace = "aws:elasticbeanstalk:managedactions"
    name      = "PreferredStartTime"
    value     = var.preferred_start_time
  }

  setting {
    namespace = "aws:elasticbeanstalk:managedactions:platformupdate"
    name      = "UpdateLevel"
    value     = var.update_level
  }


  ### Autoscale trigger configurations

  setting {
    namespace = "aws:autoscaling:trigger"
    name      = "Statistic"
    value     = var.autoscale_statistic
  }

  setting {
    namespace = "aws:autoscaling:trigger"
    name      = "MeasureName"
    value     = var.autoscale_measure_name
  }

  setting {
    namespace = "aws:autoscaling:trigger"
    name      = "Unit"
    value     = var.autoscale_unit
  }

  setting {
    namespace = "aws:autoscaling:trigger"
    name      = "LowerBreachScaleIncrement"
    value     = var.autoscale_lower_increment
  }

  setting {
    namespace = "aws:autoscaling:trigger"
    name      = "LowerThreshold"
    value     = var.autoscale_lower_bound
  }

  setting {
    namespace = "aws:autoscaling:trigger"
    name      = "UpperBreachScaleIncrement"
    value     = var.autoscale_upper_increment
  }

  setting {
    namespace = "aws:autoscaling:trigger"
    name      = "UpperThreshold"
    value     = var.autoscale_upper_bound
  }

  ### Logging configurations

  setting {
    namespace = "aws:elasticbeanstalk:cloudwatch:logs"
    name      = "StreamLogs"
    value     = var.enable_stream_logs
  }

  setting {
    namespace = "aws:elasticbeanstalk:hostmanager"
    name      = "LogPublicationControl"
    value     = var.enable_log_publication_control
  }

  setting {
    namespace = "aws:elasticbeanstalk:cloudwatch:logs"
    name      = "DeleteOnTerminate"
    value     = var.logs_delete_on_terminate
  }

  setting {
    namespace = "aws:elasticbeanstalk:cloudwatch:logs"
    name      = "RetentionInDays"
    value     = var.logs_retention_in_days
  }

  setting {
    namespace = "aws:elasticbeanstalk:cloudwatch:logs:health"
    name      = "HealthStreamingEnabled"
    value     = var.health_streaming_enabled
  }

  setting {
    namespace = "aws:elasticbeanstalk:cloudwatch:logs:health"
    name      = "DeleteOnTerminate"
    value     = var.health_streaming_delete_on_terminate
  }

  setting {
    namespace = "aws:elasticbeanstalk:cloudwatch:logs:health"
    name      = "RetentionInDays"
    value     = var.health_streaming_retention_in_days
  }


  ### ELB configurations

  setting {
    namespace = "aws:elb:loadbalancer"
    name      = "CrossZone"
    value     = "true"
  }

  setting {
    namespace = "aws:ec2:vpc"
    name      = "ELBSubnets"
    value     = join(",", module.networks.aws_subnet)
  }
 
  setting {
    namespace = "aws:elb:loadbalancer"
    name      = "SecurityGroups"
    value     = aws_security_group.allow_http_elb.id
  }
 
  setting  {
    namespace = "aws:elb:loadbalancer"
    name      = "ManagedSecurityGroup"
    value     = var.loadbalancer_managed_security_group
  }

  setting {
    namespace = "aws:elb:listener"
    name      = "ListenerProtocol"
    value     = "HTTP"
  }

  setting  {
    namespace = "aws:elb:listener"
    name      = "InstancePort"
    value     = var.application_port
  }

  setting  {
    namespace = "aws:elb:listener"
    name      = "ListenerEnabled"
    value     = var.http_listener_enabled
  }

  setting {
    namespace = "aws:elb:listener:443"
    name      = "ListenerProtocol"
    value     = "HTTPS"
  }

  setting  {
    namespace = "aws:elb:listener:443"
    name      = "InstancePort"
    value     = var.application_port
  }

  setting  {
    namespace = "aws:elb:listener:443"
    name      = "SSLCertificateId"
    value     = var.loadbalancer_certificate_arn
  }
  
  setting  {
    namespace = "aws:elb:listener:443"
    name      = "ListenerEnabled"
    value     = var.loadbalancer_certificate_arn == "" ? "false" : "true"
  }
  
  setting  {
    namespace = "aws:elb:listener:${var.ssh_listener_port}"
    name      = "ListenerProtocol"
    value     = "TCP"
  }
  
  setting  {
    namespace = "aws:elb:listener:${var.ssh_listener_port}"
    name      = "InstancePort"
    value     = "22"
  }
  
  setting  {
    namespace = "aws:elb:listener:${var.ssh_listener_port}"
    name      = "ListenerEnabled"
    value     = var.ssh_listener_enabled
  }
  
  setting  {
    namespace = "aws:elb:policies"
    name      = "ConnectionSettingIdleTimeout"
    value     = var.ssh_listener_enabled ? "3600" : "60"
  }
  
  setting  {
    namespace = "aws:elb:policies"
    name      = "ConnectionDrainingEnabled"
    value     = "true"
  }
  
  setting  {
    namespace = "aws:elbv2:loadbalancer"
    name      = "AccessLogsS3Bucket"
    value     = aws_s3_bucket.beanstalk_elb_logs.id
  }
  
  setting  {
    namespace = "aws:elbv2:loadbalancer"
    name      = "AccessLogsS3Enabled"
    value     = "true"
  }
  
  setting  {
    namespace = "aws:elbv2:loadbalancer"
    name      = "SecurityGroups"
    value     = join(",", var.loadbalancer_security_groups)
  }
  
  setting  {
    namespace = "aws:elbv2:loadbalancer"
    name      = "ManagedSecurityGroup"
    value     = var.loadbalancer_managed_security_group
  }
  
  setting  {
    namespace = "aws:ec2:vpc"
    name      = "ELBScheme"
    value     = "public"
  }
  
  setting  {
    namespace = "aws:elasticbeanstalk:environment"
    name      = "LoadBalancerType"
    value     = var.loadbalancer_type
  }
  
  setting  {
    namespace = "aws:elasticbeanstalk:environment:process:default"
    name      = "HealthCheckPath"
    value     = var.healthcheck_url
  }
  
  setting  {
    namespace = "aws:elasticbeanstalk:environment:process:default"
    name      = "Port"
    value     = var.application_port
  }
  
  setting  {
    namespace = "aws:elasticbeanstalk:environment:process:default"
    name      = "Protocol"
    value     = "HTTP"
  }

}