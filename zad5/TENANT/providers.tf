terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.74.0"
    }
  }
}
 
provider "azurerm" {
  features {}
  subscription_id = var.subscriptionID
}