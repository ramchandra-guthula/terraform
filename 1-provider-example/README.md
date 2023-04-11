 Terraform files should end with .tf extension then only terraform can read and execute those files, We need to provide the provider
```
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"  # Provider can be any cloud AWS, AZURE, GCP etc..
      version = "~> 3.27"        # Version of the provider
    }
  }

  required_version = ">= 0.14.9" # Terrafrom version to run your tf files 
}

```

Provider configuration
We can have multiple providers configuration, you can make use of other providers in case if you want to create resources in another account or with
another user 
```
provider "aws" {
  profile = "default"
  region  = "us-west-2" 
}

provider "aws" {
  profile = "default"
  region  = "us-west-2"
}

provider "aws" {
  region = "us-west-2"
  alias  = "target" # Use alias name in your resourse, where you are using this provider 
  assume_role {
    role_arn     = var.target_assume # Update var target_assume
    session_name = "automation"
  }
}

```

Resource block 
```
resource "aws_instance" "app_server" {
  ami           = "ami-830c94e3"  # arguments suplied to the resource 
  instance_type = "t2.micro"      # arguments suplied to the resource 

  tags = {
    Name = "ExampleAppServerInstance"
  }
}
```

