# Create Azure AD Application
resource "azuread_application" "app" {
  display_name = var.sp_name
}

# Create Service Principal
resource "azuread_service_principal" "sp" {
  application_id = azuread_application.app.application_id
}

# Create password (client secret)
resource "azuread_service_principal_password" "sp_password" {
  service_principal_id = azuread_service_principal.sp.id
  end_date_relative    = "8760h" # 1 year
}

# Assign role
resource "azurerm_role_assignment" "roles" {
  for_each = var.role_assignments

  principal_id         = azuread_service_principal.sp.object_id
  role_definition_name = each.value.role
  scope                = each.value.scope
}