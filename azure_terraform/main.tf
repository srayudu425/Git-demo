provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}

module "rg" {
  source   = "./modules/resource_group"
  name     = "rg-aks-demo"
  location = "EAST US 2 "
}

#module "identity" {
 # source              = "./modules/identity"
  #name                = "aks-identity"
  #location            = module.rg.location
  #resource_group_name = module.rg.name
#}

module "network" {
  source              = "./modules/network"
  vnet_name           = "aks-vnet"
  location            = module.rg.location
  resource_group_name = module.rg.name
}

module "acr" {
  source              = "./modules/acr"
  acr_name            = "aksacr12345"
  location            = module.rg.location
  resource_group_name = module.rg.name
}

module "keyvault" {
  source              = "./modules/keyvault"
  key_vault_name      = "kv-demo-a9x2k"
  location            = module.rg.location
  resource_group_name = module.rg.name
  tenant_id           = "7870b748-69be-4cb3-b6bf-f5c60c8a2319"
}

#Create Secret in Key Vault
resource "azurerm_key_vault_secret" "vm_password" {
  name         = "vm-password"
  value        = "Password@1234"
  key_vault_id = module.keyvault.id
}


#Read Secret (Data Source)
#data "azurerm_key_vault_secret" "vm_password" {
  #name         = "vm-password"
  #key_vault_id = module.keyvault.id
#}


module "aks" {
  source              = "./modules/aks"
  cluster_name        = "aks-demo-cluster"
  location            = module.rg.location
  resource_group_name = module.rg.name

  subnet_id = module.network.subnet_id
  acr_id    = module.acr.acr_id
  #identity_id           = module.identity.id
  #identity_principal_id = module.identity.principal_id
  node_count = 1
  vm_size = "Standard_D2_v3"
}

module "nsg" {
  source              = "./modules/nsg"
  name                = "aks-nsg"
  location            = module.rg.location
  resource_group_name = module.rg.name

  subnet_id = module.network.subnet_id
}
#attach nsg to subnet
resource "azurerm_subnet_network_security_group_association" "nsg-assoc" {
  subnet_id                 = module.network.subnet_id
  network_security_group_id = module.nsg.nsg_id
}

module "data_disk" {
  source              = "./modules/data_disk"
  disk_name           = "vm1-data-disk"
  location            = module.rg.location
  resource_group_name = module.rg.name
  disk_size_gb        = 5

}

module "nic" {
  source              = "./modules/nic"
  nic_name            = "vm-nic"
  location            = module.rg.location
  resource_group_name = module.rg.name
  subnet_id = module.network.subnet_id
}

module "vm" {
  source = "./modules/vm"

  vm_name             = "myvm01"
  location            = module.rg.location
  resource_group_name = module.rg.name

  nic_id       = module.nic.nic_id
  data_disk_id = module.data_disk.disk_id

  admin_username = "azureuser"
  admin_password = azurerm_key_vault_secret.vm_password.value
}


module "sp" {
  source = "./modules/service_principal"

  sp_name = "terraform-sp"
    role_assignments = {
    acr = {
      role  = "AcrPush"
      scope = azurerm_container_registry.acr.id
    }

    aks = {
      role  = "Azure Kubernetes Service RBAC Writer"
      scope = azurerm_kubernetes_cluster.aks.id
    }
  }
}