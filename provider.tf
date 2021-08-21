terraform {
  required_version = ">= 0.14.0"
}

provider "aws" {
  version = ">= 2.28.1"
  region  = var.region
}