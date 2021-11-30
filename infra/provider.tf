/*terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.56.0"
    }
  }
  backend "s3" {
      bucket = "pgr301-haha029-terraform"
      key    = "hagenh/terraform_haha029.state"
      region = "eu-west-1"
    }
}

//provider "aws" {
//region = "eu-west-1"
//}*/
terraform {
  backend "remote" {
    organization = "hagen"

    workspaces {
      name = "Devops-Exam"
    }
  }
}



resource "aws_ecr_repository" "ecr" {
  name                 = "haha029"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    name = "ecr"
  }

}