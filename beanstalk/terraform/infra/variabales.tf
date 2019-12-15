variable "ssh_key_name" {
	default = "rondi-key-temp"
}
variable "region" {
	default="us-west-2"
}

variable "associate_public_ip_address" {
	type = bool
	default = true
}
variable "environment_type" {
	type = string
	default = "LoadBalanced"
}
variable "name" {
  	type        = string
  	description = "App name"
  	default = "beanstalk_aws_lab"
}
variable "hostname" {
  	type        = string
  	description = "App name"
  	default = "beanstalk_aws_lab"
}
variable "autoscale_min" {
	type = number
	default = 1
}
variable "autoscale_max" {
	type = number
	default = 2
}
variable "updating_min_in_service" {
	type = number
	default = 1
}
variable "updating_max_batch" {
	type = number
	default = 2
}
variable "instance_type" {
	type = string
	default = "t2.micro"
}
variable "root_volume_size" {
	type = number
	default = 20
}
variable "root_volume_type" {
	type = string
	default = "gp2"
}
variable "instance_refresh_enabled" {
	type = bool
	default = true
}
variable "preferred_start_time" {
	type        = string
	default = "Sun:10:00"
}
variable "update_level" {
	type        = string
	default = "minor"
}
variable "autoscale_statistic" {
	type        = string
	default = "Average"
}
variable "autoscale_measure_name" {
	type        = string
	default = "CPUUtilization"
}
variable "autoscale_unit" {
	type        = string
	default = "Percent"
}
variable "autoscale_lower_increment" {
	type        = number
	default = -1
}
variable "autoscale_lower_bound" {
	type        = number
	default = 80
}
variable "autoscale_upper_increment" {
	type        = number
	default = 1
}
variable "autoscale_upper_bound" {
	type        = number
	default = 80
}
variable "enable_stream_logs" {
	type        = bool
	default = false
}
variable "enable_log_publication_control" {
	type        = bool
	default = false
}
variable "logs_delete_on_terminate" {
	type        = bool
	default = false
}
variable "logs_retention_in_days" {
	type        = number
	default = 7
}
variable "health_streaming_enabled" {
	type        = bool
	default = false
}
variable "health_streaming_delete_on_terminate" {
	type        = bool
	default = false
}
variable "health_streaming_retention_in_days" {
	type        = number
	default = 7
}

variable "ssh_listener_port" {
	type = number
	default = 22
}

variable "application_port" {
	type = number
	default = 80
}

variable "http_listener_enabled" {
	type = bool
	default = true
}
variable "loadbalancer_certificate_arn"{
	type = string
	default = ""
}

variable "ssh_listener_enabled" {
	type = bool
	default = true
}

variable "loadbalancer_type" {
	type = string
	default = "classic"
}

variable "healthcheck_url" {
	type = string
	default = "/"
}

variable "availability_zone_selector" {
  type        = string
  default     = "Any 2"
  description = "Availability Zone selector"
}

variable "loadbalancer_managed_security_group" {
  type        = string
  default     = ""
  description = "Load balancer managed security group"
}

variable "loadbalancer_security_groups" {
	type        = list(string)
	default     = []
	description = "Load balancer security groups"
}

variable "env_vars" {
	type = list(object({
		key = string
		value = string
	}))
	default = [
		{
		    key       = "TEST_ENV_VAR"
		    value     = "aws_lab_beanstalk"
	  	}
	]
	description = "Additional Elastic Beanstalk setttings. For full list of options, see https://docs.aws.amazon.com/elasticbeanstalk/latest/dg/command-options-general.html"
}

variable "additional_settings" {
  type = list(object({
    namespace = string
    name      = string
    value     = string
  }))
  description = "Additional Elastic Beanstalk setttings. For full list of options, see https://docs.aws.amazon.com/elasticbeanstalk/latest/dg/command-options-general.html"
  default = []
}
