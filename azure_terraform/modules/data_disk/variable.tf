variable "disk_name" {}
variable "location" {}
variable "resource_group_name" {}
variable "disk_size_gb" {}

variable "storage_account_type" {
  default = "Standard_LRS"
}