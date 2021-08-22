terraform {
  backend "remote" {
    organization = "yushin-private"

    workspaces {
      name = "aws-mlops"
    }
  }
}