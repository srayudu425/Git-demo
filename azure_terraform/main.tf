provider "azurerm" {
  features {}
}

module "rg" {
  source   = "./modules/resource_group"
  name     = "rg-aks-demo"
  location = "East US 2"
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
  vm_size = "Standard_B2s"
}

