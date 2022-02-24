variable "vpc_name" {
  type        = string
  description = "Tag name to your VPC"
  default     = "myapp-vpc"
}

variable "ip_ranges" {
  type = list(object({
    vpc_range             = string 
    public_subnet_range   = string
    private_subnet_range  = string
  }))
  default = [
    {
      vpc_range            = "10.0.0.0/16"
      public_subnet_range  = "10.0.2.0/24"
      private_subnet_range = "10.0.3.0/24"
    }
  ]
}

