terraform {
  required_version = ">= 1.8"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.34"
    }
  }
}

provider "aws" {
  region = "us-west-2"
}

# module "secrets_manager" {
#   source  = "terraform-aws-modules/secrets-manager/aws"
#   version = "~> 1.1"

#   name                    = "ecr-pullthroughcache/docker"
#   secret_string           = jsonencode(var.docker_secret)
#   recovery_window_in_days = 0 # Set to 0 for testing purposes, this will immediately delete the secret. This action is irreversible. https://docs.aws.amazon.com/secretsmanager/latest/apireference/API_DeleteSecret.html
# }

module "ecr" {
  source  = "terraform-aws-modules/ecr/aws"
  version = "~> 2.2"

  create_repository = false

  registry_pull_through_cache_rules = {
    ecr = {
      ecr_repository_prefix = "ecr"
      upstream_registry_url = "public.ecr.aws"
    }
    k8s = {
      ecr_repository_prefix = "k8s"
      upstream_registry_url = "registry.k8s.io"
    }
    quay = {
      ecr_repository_prefix = "quay"
      upstream_registry_url = "quay.io"
    }
    dockerhub = {
      ecr_repository_prefix = "docker-hub"
      upstream_registry_url = "registry-1.docker.io"
    #   credential_arn        = module.secrets_manager.secret_arn
    }
  }
}