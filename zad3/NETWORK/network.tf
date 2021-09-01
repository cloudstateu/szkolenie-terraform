
resource "azurerm_virtual_network" "ntier" {
  name                = "ntier-net"
  location            = var.location
  resource_group_name = var.rg_name
  address_space       = ["10.0.0.0/16"]

}

resource "azurerm_subnet" "frontend" {
  name                 = "frontend"
  resource_group_name  = var.rg_name
  virtual_network_name = azurerm_virtual_network.ntier.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_subnet" "backend" {
  name                 = "backend"
  resource_group_name  = var.rg_name
  virtual_network_name = azurerm_virtual_network.ntier.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_subnet" "data" {
  name                 = "data"
  resource_group_name  = var.rg_name
  virtual_network_name = azurerm_virtual_network.ntier.name
  address_prefixes     = ["10.0.3.0/24"]
}

resource "azurerm_public_ip" "frontend_public_ip" {
  name                = "frontend-ip"
  resource_group_name = var.rg_name
  location            = var.location
  allocation_method   = "Dynamic"
}

resource "azurerm_network_interface" "front_vm_nic" {
  name                = "front-vm-nic"
  location            = var.location
  resource_group_name = var.rg_name

  ip_configuration {
    name                          = "front"
    subnet_id                     = azurerm_subnet.frontend.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.frontend_public_ip.id
  }
}

resource "azurerm_network_interface" "backend_vm_nic" {
  name                = "backend-vm-nic"
  location            = var.location
  resource_group_name = var.rg_name

  ip_configuration {
    name                          = "backend"
    subnet_id                     = azurerm_subnet.backend.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_network_interface" "data_vm_nic" {
  name                = "data-vm-nic"
  location            = var.location
  resource_group_name = var.rg_name

  ip_configuration {
    name                          = "data"
    subnet_id                     = azurerm_subnet.data.id
    private_ip_address_allocation = "Dynamic"
  }
}