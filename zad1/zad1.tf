resource "azurerm_resource_group" "rg1" {
    name     = "zad1-rg"
    location = var.location
}

resource "azurerm_virtual_network" "vnet1" {
    name                = "vnet1"
    location            = azurerm_resource_group.rg1.location
    address_space       = ["10.0.0.0/16"]
    resource_group_name = azurerm_resource_group.rg1.name
}

resource "azurerm_subnet" "sub1" {
    name                 = "sub1"
    resource_group_name  = azurerm_resource_group.rg1.name
    virtual_network_name = azurerm_virtual_network.vnet1.name
    address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_network_interface" "nic1" {
    name                = "nic1"
    resource_group_name = azurerm_resource_group.rg1.name
    location            = azurerm_resource_group.rg1.location

    ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.sub1.id
    private_ip_address_allocation = "Dynamic"
    }
}

resource "azurerm_linux_virtual_machine" "VM1" {
  name                            = "vm1"
  resource_group_name             = azurerm_resource_group.rg1.name
  location                        = azurerm_resource_group.rg1.location
  size                            = "Standard_D2s_v3"
  admin_username                  = var.admin_VM1
  admin_password                  = var.password_VM1
  disable_password_authentication = false
  network_interface_ids = [
    azurerm_network_interface.nic1.id,
  ]

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }
}