terraform {
  backend "azurerm" {
    resource_group_name  = "rg-tfstate"
    storage_account_name = "tfstate12345"
    container_name       = "tfstatest"
    key                  = "terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
  use_oidc = true
}

# Resource Group
resource "azurerm_resource_group" "tfstate_rg" {
  name     = "rg-tfstate"
  location = "Central India"
}

# Storage Account
resource "azurerm_storage_account" "tfstate_sa" {
  name                     = "tfstate12345" # must be globally unique
  resource_group_name      = azurerm_resource_group.tfstate_rg.name
  location                 = azurerm_resource_group.tfstate_rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  # Recommended settings
  min_tls_version          = "TLS1_2"
  allow_nested_items_to_be_public = false
}

# Storage Container
resource "azurerm_storage_container" "tfstate_container" {
  name                  = "tfstate"
  storage_account_name  = azurerm_storage_account.tfstate_sa.name
  container_access_type = "private"
}