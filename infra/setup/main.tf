terraform {
    required_providers{
        aws = {
            source = "hashicorp/aws"
            version = "5.23.0"
        }
    }
      
      backend "s3" {
        bucket = "devops-terrafrom-state"
        key = "devops-tf-state-setup"
        region = "us-east-1"
        encrypt = true
        dynamodb_table = "devops-lockTable"
        
      }
 }

 provider "aws" {
   region = "us-east-1"

   default_tags {
    tags = {
      Environment = Terraform_workspace
      auto-delete = no
    }
     
  }
}
