variable "aws_image_id" {
  type        = string
  description = "The id of the machine image (AMI) to use for the server."
  default     = "ami-0c6615d1e95c98aca"
}

variable "image_tags" {
  type        = string
  description = "tag name to the instance"
  default     = "app_server"
}
