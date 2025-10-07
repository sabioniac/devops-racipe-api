#########
terraform {
    required_providers{
        aws = {
            source = "hashicorp/aws"
            version = "5.23.0"
        }
    }
      
      backend "s3" {
        bucket = "devops-terrafrom-state"
        key = "devops-tf-state-deploy"
        workspace_key_prefix = "tf-state-deploy-env"
        region = "us-east-1"
        encrypt = true
        dynamodb_table = "devops-lockTable"
        
      }
 }

 provider "aws" {
   region = "us-east-1"

   default_tags {
    tags = {
      Environment = Terraform.Environment
      ManageBy = "Terraform/deploy"
    }
     
  }
}
locals{
  prefix ="${var.prefix}-${terraform.workspace}"
}  
data "aws_region" "current" {}
