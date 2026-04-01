resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.cluster_name
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = "aksdemo"  #a DNS name for the AKS API server (control plane)(kubectl use chesi cluster ni access cheyadaniki)

  default_node_pool {
    name       = "nodepool"
    node_count = var.node_count
    vm_size    = var.vm_size
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {            #Networking config
    network_plugin = "azure"   #Pod gets real VNet IP(Azure CNI = Pods are like VMs in VNet)
  }
}