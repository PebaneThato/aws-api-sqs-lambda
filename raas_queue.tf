resource "aws_sqs_queue" "raas-queue" {
  name                      = "raas-queue"
  delay_seconds             = 0
  max_message_size          = 262144
  message_retention_seconds = 86400
  receive_wait_time_seconds = 10

  tags = {
    Owner          = var.teamcode
    Environment    = var.environment
    Resource_Group = "raas-sqs"
  }
}
