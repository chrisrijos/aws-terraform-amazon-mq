# Specify the provider and access details
provider "aws" {
  region                       = "${var.aws_region}"
  profile                      = "${var.aws_profile}"
}

resource "aws_mq_broker" "broker" {
  broker_name                  = "${var.environment_name}_mq_broker"
  engine_type                  = "ActiveMQ"
  engine_version               = "5.15.0"
  auto_minor_version_upgrade   = true
  deployment_mode              = "ACTIVE_STANDBY_MULTI_AZ"
  subnet_ids                   = ["${var.aws_subnet_ids}"]
  security_groups              = ["${var.aws_security_group_ids}"]
  host_instance_type           = "${var.aws_instance_type}"
  publicly_accessible          = true
  user {
    username                   = "${var.aws_mq_username}"
    password                   = "${var.aws_mq_password}"
    console_access             = true
  }
}
