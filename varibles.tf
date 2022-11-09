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
    default     = "rca"
}

locals {
    description = "Aplication Name"
    app_name = "${var.name}-${var.environment}"
}

variable "region" {
    default = "us-east-2"
}

variable "lambda_name" {
    description = "Name for lambda function"
    default = "raas_python"
}
