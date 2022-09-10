terraform {
  backend "s3" {
    bucket  = "terraform-states-054362003732"
    encrypt = true
    key     = "headversity_devops/terraform.tfstate"
    region  = "us-east-1"
  }
}
