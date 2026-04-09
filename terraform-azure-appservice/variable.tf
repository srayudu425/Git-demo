variable "resource_group_name" {
  default = "rg-free-appservice"
}

variable "location" {
  default = "Central India"
}

variable "app_service_plan_name" {
  default = "fre-asp-plan"
}

variable "app_name" {
  default = "sanjeeva-free-app123" # MUST be globally unique
}