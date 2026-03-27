variable "nic_name" {}
variable "location" {}
variable "resource_group_name" {}
variable "subnet_id" {}

variable "private_ip_allocation" {
  default = "Dynamic"
}

variable "public_ip_id" {
  default = null
}