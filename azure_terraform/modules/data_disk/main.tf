resource "azurerm_managed_disk" "data_disk" {
  name                 = var.disk_name
  location             = var.location
  resource_group_name  = var.resource_group_name
  storage_account_type = var.storage_account_type
  create_option        = "Empty"
  disk_size_gb         = var.disk_size_gb
}

resource "azurerm_virtual_machine_data_disk_attachment" "attach" {
  managed_disk_id    = azurerm_managed_disk.data_disk.id
  virtual_machine_id = var.vm_id
  lun                = var.lun
  caching            = var.caching
}