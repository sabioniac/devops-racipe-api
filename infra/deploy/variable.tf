variable "prefix" {
    description = "prefix for resources in AWS"
    default = "raa"
}

variable "project" {
  description = "Project name for tagging resources"
  default = "devops-api"
}

variable "contact" {
  description = "Contact name for tagging resources"
  default = "test@test.com"
}
