resource "azurerm_linux_virtual_machine" "vm" {
  name                = var.vm_name
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = "Standard_D2_v3"

  admin_username = var.admin_username
  admin_password = var.admin_password

  network_interface_ids = [
    var.nic_id
  ]

  disable_password_authentication = false

  identity {
    type = "SystemAssigned"
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
}

# Attach data disk
resource "azurerm_virtual_machine_data_disk_attachment" "attach" {
  managed_disk_id    = var.data_disk_id
  virtual_machine_id = azurerm_linux_virtual_machine.vm.id
  lun                = 0
  caching            = "ReadWrite"
}