resource "azurerm_network_security_group" "front_nsg" {
  name                = "nsg-frontend"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
}

resource "azurerm_network_security_group" "backend_nsg" {
  name                = "nsg-backend"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
}

resource "azurerm_network_security_group" "data_nsg" {
  name                = "nsg-data"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
}

resource "azurerm_network_security_rule" "frontend_allow_ssh" {
    name                       = "AllowSSH"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "TCP"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "94.75.112.0/24"
    destination_address_prefix = "*"
    resource_group_name         = data.azurerm_resource_group.rg.name
    network_security_group_name = azurerm_network_security_group.front_nsg.name
}

resource "azurerm_network_security_rule" "FrontendDenyVnetInBound" {
    name                       = "DenyVnetInBound"
    priority                   = 120
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = "VirtualNetwork"
    resource_group_name         = data.azurerm_resource_group.rg.name
    network_security_group_name = azurerm_network_security_group.front_nsg.name
}

resource "azurerm_subnet_network_security_group_association" "frontend-nsg" {
  subnet_id                 = data.azurerm_subnet.frontend_subnet.id
  network_security_group_id = azurerm_network_security_group.front_nsg.id
}

resource "azurerm_network_security_rule" "BackendAllowFrontendInBound"{
    name                       = "AllowFrontendVnetInBound"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = data.azurerm_subnet.frontend_subnet.address_prefix
    destination_address_prefix = "VirtualNetwork"
    resource_group_name         = data.azurerm_resource_group.rg.name
    network_security_group_name = azurerm_network_security_group.backend_nsg.name
}

resource "azurerm_network_security_rule" "BackendDenyVnetInBound" {
    name                       = "DenyVnetInBound"
    priority                   = 120
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = "VirtualNetwork"
    resource_group_name         = data.azurerm_resource_group.rg.name
    network_security_group_name = azurerm_network_security_group.backend_nsg.name
}

resource "azurerm_subnet_network_security_group_association" "backend-nsg" {
  subnet_id                 = data.azurerm_subnet.backend_subnet.id
  network_security_group_id = azurerm_network_security_group.backend_nsg.id
}

resource "azurerm_network_security_rule" "DataAllowBackendInBound"{
    name                       = "AllowBackendVnetInBound"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = data.azurerm_subnet.backend_subnet.address_prefix
    destination_address_prefix = "VirtualNetwork"
    resource_group_name         = data.azurerm_resource_group.rg.name
    network_security_group_name = azurerm_network_security_group.data_nsg.name
}

resource "azurerm_network_security_rule" "DataDenyVnetInBound" {
    name                       = "DenyVnetInBound"
    priority                   = 120
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = "VirtualNetwork"
    resource_group_name         = data.azurerm_resource_group.rg.name
    network_security_group_name = azurerm_network_security_group.data_nsg.name
}

resource "azurerm_subnet_network_security_group_association" "data-nsg" {
  subnet_id                 = data.azurerm_subnet.data_subnet.id
  network_security_group_id = azurerm_network_security_group.data_nsg.id
}