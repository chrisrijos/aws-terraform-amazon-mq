
output "aws_mq_broker_id" {
  value = "${aws_mq_broker.broker.id}"
}

output "aws_mq_broker_active_endpoint" {
  value = "${aws_mq_broker.broker.instances.0.endpoints}"
}

output "aws_mq_broker_standby_endpoint" {
  value = "${aws_mq_broker.broker.instances.1.endpoints}"
}
