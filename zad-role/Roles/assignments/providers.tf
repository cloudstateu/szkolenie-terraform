terraform {
  required_providers {
    # azuread = {
    #   source  = "hashicorp/azuread"
    #   version = "~> 2.0.0"
    # }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.74.0"
    }
  }
}

# provider "azuread" {
#   tenant_id = "3a81269f-0731-42d7-9911-a8e9202fa750"
# }

provider "azurerm" {
  features {}
  subscription_id = var.sub_id
}