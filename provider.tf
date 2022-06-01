terraform {
    backend "s3" {
      bucket = "tf-state-eks-8b2a91c8b2"
      key            = "eks/terraform.tfstate"
      region = "us-east-1"
    }
}