terraform {
  backend "remote" {
    organization = "yushin-private"

    workspaces {
      name = "mlops"
    }
  }
}
