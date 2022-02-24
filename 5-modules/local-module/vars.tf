variable "aws_image_id" {
  type        = string
  description = "The id of the machine image (AMI) to use for the server."
  default     = "ami-0c6615d1e95c98aca"
}

variable "app_name" {
  type        = string
  description = "App name to the project"
  default     = "myApp"
}
