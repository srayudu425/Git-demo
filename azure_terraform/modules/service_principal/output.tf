output "client_id" {
  value = azuread_application.app.client_id
}

output "client_secret" {
  value     = azuread_service_principal_password.sp_password.value
  sensitive = true
}

output "tenant_id" {
  value = data.azurerm_client_config.current.tenant_id
}