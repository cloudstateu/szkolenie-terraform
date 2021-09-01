resource "azurerm_linux_virtual_machine" "frontend-vm" {
    name                            = "frontend-vm"
    resource_group_name             = data.azurerm_resource_group.rg.name
    location                        = data.azurerm_resource_group.rg.location
    size                            = "Standard_D2s_v3"
    admin_username                  = var.username
    admin_password                  = var.password
    disable_password_authentication = false
    
    network_interface_ids = [
        data.azurerm_network_interface.frontend-nic.id
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

resource "azurerm_linux_virtual_machine" "backend-vm" {
    name                            = "backend-vm"
    resource_group_name             = data.azurerm_resource_group.rg.name
    location                        = data.azurerm_resource_group.rg.location
    size                            = "Standard_D2s_v3"
    admin_username                  = var.username
    admin_password                  = var.password
    disable_password_authentication = false
    
    network_interface_ids = [
        data.azurerm_network_interface.backend-nic.id
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

resource "azurerm_linux_virtual_machine" "data-vm" {
    name                            = "data-vm"
    resource_group_name             = data.azurerm_resource_group.rg.name
    location                        = data.azurerm_resource_group.rg.location
    size                            = "Standard_D2s_v3"
    admin_username                  = var.username
    admin_password                  = var.password
    disable_password_authentication = false
    
    network_interface_ids = [
        data.azurerm_network_interface.data-nic.id
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