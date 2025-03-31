terraform {
  required_providers {
    spacelift = {
      source  = "spacelift-io/spacelift"
      version = "~> 0.1.11"
    }
  }
}

provider "aws" {
  region = "us-west-2"
}
