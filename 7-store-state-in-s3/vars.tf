variable "aws_image_id" {
  type        = string
  description = "The id of the machine image (AMI) to use for the server."
  default     = "" #"ami-0c6615d1e95c98aca"
}

variable "image_tags" {
  type        = string
  description = "tag name to the instance"
  default     = "app_server"
}

variable "instance_tags" {
  type        = list
  description = "tag name to the instance"
  default     = ["app_server", "DB-server", "cache-server"]
}

variable "other_tags" {
  type        = map
  description = "tag name to the instance"
  default     = {
		"type" = "app_server"
		"env" = "Dev"
	}
}

