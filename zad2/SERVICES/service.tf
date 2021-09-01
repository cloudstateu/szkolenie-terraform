resource "azurerm_cosmosdb_account" "cosmos" {
    name                = var.cosmosdb_name
    location            = azurerm_resource_group.rg2.location
    resource_group_name = azurerm_resource_group.rg2.name
    offer_type          = "Standard"
    kind                = "MongoDB"

    capabilities {
    name = "EnableMongo"
    }

    consistency_policy {
    consistency_level = "Eventual"
    }

    geo_location {
    location          = azurerm_resource_group.rg2.location
    failover_priority = 0
    }
}