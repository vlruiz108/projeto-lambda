provider "aws" {
  region = "us-east-1"  # Substitua pela região desejada
}

resource "aws_lambda_function" "my_lambda_function" {
  filename      = "lambda_function.zip"
  function_name = "myLambdaFunction"
  role          = aws_iam_role.lambda_exec.arn
  handler       = "main.lambda_handler"
  runtime       = "python3.7"
  timeout       = 10

  environment {
    variables = {
      VAULT_ADDR   = var.vault_addr,
      VAULT_TOKEN  = var.vault_token,
      SECRET_PATH  = var.secret_path,
    }
  }
}

resource "aws_iam_role" "lambda_exec" {
  name = "lambda_exec_role"

  assume_role_policy = <<EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": "sts:AssumeRole",
        "Effect": "Allow",
        "Principal": {
          "Service": "lambda.amazonaws.com"
        }
      }
    ]
  }
  EOF
}

variable "vault_addr" {
  description = "Vault address"
}

variable "vault_token" {
  description = "Vault token"
}

variable "secret_path" {
  description = "Path to the secret in Vault"
}
