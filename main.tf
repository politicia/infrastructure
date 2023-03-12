terraform {
  backend "s3" {
    bucket = "terraform-yany"
    key    = "terraform/terraform.tfstate"
    region         = "ap-northeast-2"  
    encrypt        = true
  }
}

