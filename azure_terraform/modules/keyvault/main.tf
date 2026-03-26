resource "azurerm_key_vault" "kv" {
  name                = var.key_vault_name
  location            = var.location
  resource_group_name = var.resource_group_name
  tenant_id           = var.tenant_id

  sku_name = var.sku_name

  enable_rbac_authorization = var.enable_rbac_authorization

  purge_protection_enabled  = true   #Even admins cannot permanently delete immediately
  soft_delete_retention_days = 7

  public_network_access_enabled = false
}