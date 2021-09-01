data "azurerm_subnet" "backend_subnet" {
  name                 = "backend"
  virtual_network_name = "ntier-net"
  resource_group_name  = "zad3"
}

data "azurerm_subnet" "frontend_subnet" {
  name                 = "frontend"
  virtual_network_name = "ntier-net"
  resource_group_name  = "zad3"
}

data "azurerm_subnet" "data_subnet" {
  name                 = "data"
  virtual_network_name = "ntier-net"
  resource_group_name  = "zad3"
}

data "azurerm_resource_group" "rg" {
  name = "zad3"
}

data "azurerm_network_interface" "frontend-nic" {
  name                = "front-vm-nic"
  resource_group_name = "zad3"
}

data "azurerm_network_interface" "backend-nic" {
  name                = "backend-vm-nic"
  resource_group_name = "zad3"
}

data "azurerm_network_interface" "data-nic" {
  name                = "data-vm-nic"
  resource_group_name = "zad3"
}