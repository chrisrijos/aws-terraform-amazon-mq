# AWS / Terraform Amazon MQ

Create a VPC with a couple of subnets hosting a resilient [Amazon MQ](https://console.aws.amazon.com/amazon-mq/home?region=us-east-1#/first-run)

```commandline
terraform plan -var "aws_key_name=amazon_mq_dev" -var "aws_region=us-east-1"
terraform apply -var "aws_key_name=amazon_mq_dev" -var "aws_region=us-east-1"
```
