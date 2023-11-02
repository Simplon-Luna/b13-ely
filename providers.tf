terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = ">3.0"
    }
    ansible = {
      version = "~> 1.1.0"
      source  = "ansible/ansible"
    }
  }
  }
}

provider "azurerm" {
  features {}
  tenant_id = "a2e466aa-4f86-4545-b5b8-97da7c8febf3"
  subscription_id = "a1f74e2d-ec58-4f9a-a112-088e3469febb"
}
