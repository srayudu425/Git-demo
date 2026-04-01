variable "key_vault_name" {}
variable "location" {}
variable "resource_group_name" {}
variable "tenant_id" {}

variable "sku_name" {
  default = "standard"
}

variable "enable_rbac_authorization" {
  default = true
}