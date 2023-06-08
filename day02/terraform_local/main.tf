# Add the required_providers block
terraform {
  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "2.1.0"
    }
  }
}

# Use the variable in the local_sensitive_file resource
resource "local_file" "passwords" {
  filename = "/home/ubuntu/TerraWeekChallenge/day02/terraform_local/pass.txt"
  content  = var.file_content
}

