terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.89.0"
    }
  }
}

provider "aws" {
  region     = "us-east-1"
  access_key = "AKIASBQ6Y435Q66OWT7W"
  secret_key = "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"
}
