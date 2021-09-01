resource "azurerm_virtual_network" "vnet2" {
    name                = "vnet2"
    location            = azurerm_resource_group.rg2.location
    address_space       = ["10.0.0.0/16"]
    resource_group_name = azurerm_resource_group.rg2.name
}

resource "azurerm_subnet" "sub2" {
    name                 = "sub2"
    resource_group_name  = azurerm_resource_group.rg2.name
    virtual_network_name = azurerm_virtual_network.vnet2.name
    address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_private_endpoint" "cosmos-pe" {
    name                 = "cosmos-pe"
    location             = azurerm_resource_group.rg2.location
    resource_group_name  = azurerm_resource_group.rg2.name
    subnet_id            = azurerm_subnet.sub2.id

    private_service_connection {
    name                           = "cosmosdb-connection"
    is_manual_connection           = false
    private_connection_resource_id = azurerm_cosmosdb_account.cosmos.id
    subresource_names              = ["MongoDB"]
    }
}