data "azurerm_resource_group" "rg2" {
  name = "zad2-rg"
}

data "azurerm_cosmosdb_account" "cosmos" {
  name                = "cosmosdb2"
  resource_group_name = "szkolenie-rg2"
}