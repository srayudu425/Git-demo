#output "app_url" {
  #value = "https://${azurerm_linux_web_app.app.default_hostname}"
#}


#output "storage_account_name" {
  #value = azurerm_storage_account.tfstate_sa.name
#}

#output "container_name" {
  #value = azurerm_storage_container.tfstate_container.name
#}

output "function_app_name" {
  value = azurerm_linux_function_app.func.name
}