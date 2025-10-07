#######
variable "tf_state_bucket" {
  description = "Name of the S3 bucket in AWS for storing TF state"
  default     = "devops-terrafrom-state"
}

variable "tf_state_lock_table" {
  description = "Name of the DynamoDB table for TF state locking"
  default     = "devops-lockTable"
}

variable "project" {
  description = "Project name for tagging resources"
  default     = "devops-api"
}

variable "contact" {
  description = "Contact name for tagging resources"
  default     = "test@test.com"
}
 
