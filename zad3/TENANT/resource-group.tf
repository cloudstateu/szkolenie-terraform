resource "azurerm_resource_group" "main-rg" {
    name = var.rg_name
    location = var.location
}