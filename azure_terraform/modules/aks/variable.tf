variable "cluster_name" {}
variable "location" {}
variable "resource_group_name" {}
#variable "identity_principal_id" {}
variable "node_count" {
  default = 1
}
variable "subnet_id" {}
variable "acr_id" {}
variable "vm_size" {
default = "Standard_B2s"
}
