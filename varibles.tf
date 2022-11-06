variable "environment" {
    description = "Env"
    default     = "dev"
}

variable "teamcode" {
    description = "Env"
    default     = "dev"
}

variable "name" {
    description = "Application Name"
    type        = string
    default     = "dev"
}

locals {
    description = "Aplication Name"
    app_name = "${var.name}-${var.environment}"
}

variable "region" {
    default = "us-east-1"
}

variable "lambda_name" {
    description = "Name for lambda function"
    default = "lambda"
}
