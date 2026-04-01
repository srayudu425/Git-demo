resource "azurerm_managed_disk" "data_disk" {
  name                 = var.disk_name
  location             = var.location
  resource_group_name  = var.resource_group_name
  storage_account_type = var.storage_account_type  #Performance
  create_option        = "Empty"          #(empty = New disk ,Attach=existing , FromImage = from image)
  disk_size_gb         = var.disk_size_gb      #Capacity
}

