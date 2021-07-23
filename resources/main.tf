provider "aws" {
    region = "ap-southeast-2"
}

module "s3_bucket" {
    source = "terraform-aws-modules/s3-bucket/aws"

    bucket = "mlops-platform-training-data"
    acl = "private"

    versioning = {
        enabled = true
    }
}