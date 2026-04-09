provider "azurerm" {
  features {}
  use_oidc = true
}

# Resource Group
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

# App Service Plan (Free Tier)
resource "azurerm_service_plan" "asp" {
  name                = var.app_service_plan_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  os_type  = "Linux"
  sku_name = "F1"   # FREE TIER
}

# Linux Web App
resource "azurerm_linux_web_app" "app" {
  name                = var.app_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  service_plan_id     = azurerm_service_plan.asp.id

  site_config {
    always_on = false
    application_stack {
      node_version = "18-lts"   # Change based on your app
    }
  }

  app_settings = {
    "WEBSITES_PORT" = "3000"
  }
}

# Storage Account
resource "azurerm_storage_account" "tfstate_sa" {
  name                     = "tfstatestapp1234" # must be globally unique
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  # Recommended settings
  min_tls_version          = "TLS1_2"
  allow_nested_items_to_be_public = false
}

# Storage Container
resource "azurerm_storage_container" "tfstate_container" {
  name                  = "tfstateapp"
  storage_account_name  = azurerm_storage_account.tfstate_sa.name
  container_access_type = "private"
}

