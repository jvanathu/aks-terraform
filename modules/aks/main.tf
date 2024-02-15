# ---------------------------------------------------------------
# Purpose: Create the aks resources for the environment
# ---------------------------------------------------------------

# ---------------------------------------------------------------
# Local variables to hold resource names
# ---------------------------------------------------------------
locals {
  resource_group_name = "rg-${var.environment.name}-aks-${var.region_name_mapper[var.aks.location]}"
  aks_name            = "aks-${var.environment.name}-${var.region_name_mapper[var.aks.location]}"
  system_node_pool_name           = "sysnp"
  subnet_id     = var.network_out[var.aks.location].subnets.aks.id

}

# ---------------------------------------------------------------
# Data source to retrieve resource attributes
# ---------------------------------------------------------------
# data "azurerm_subnet" "aks_subnet" {
#   name                 = "sn-aks"
#   virtual_network_name = local.vnet_name
#   resource_group_name  = local.vnet_resource_group_name
# }
# # Datasource to get Latest Azure AKS latest Version
# data "azurerm_kubernetes_service_versions" "current" {
#   location = var.location
#   include_preview = false  
# }

# ---------------------------------------------------------------
# Resource group for the aks
# ---------------------------------------------------------------
resource "azurerm_resource_group" "rg" {
  name     = local.resource_group_name
  location = var.aks.location
  tags     = var.tags
}


resource "azurerm_kubernetes_cluster" "aks" {
  name                = local.aks_name
  location            = var.aks.location
  resource_group_name = local.resource_group_name
  dns_prefix          = "aks-${var.environment.name}"

  default_node_pool {
    name            = "default"
    node_count      = var.aks.node_count
    vm_size         = var.aks.vm_size
    vnet_subnet_id  = local.subnet_id
    // Optionally, add other configurations as needed
  }

  network_profile {
    network_plugin     = "azure"
    network_policy     = "calico"
    # service_cidr       = null // var.aks.service_cidr
    # dns_service_ip     = null //var.aks.dns_service_ip
    # docker_bridge_cidr = null //var.docker_bridge_cidr
    # // Enable private cluster
    # load_balancer_sku = null // "standard"
    # outbound_type     = null // "userDefinedRouting"
  }

  private_cluster_enabled = true
 
  identity {
    type = "SystemAssigned"
  }

  tags = var.tags
}
resource "azurerm_kubernetes_cluster_node_pool" "system" {
  name                  = local.system_node_pool_name
  kubernetes_cluster_id = azurerm_kubernetes_cluster.aks.id
  vm_size               = var.aks.vm_size_system
  node_count            = var.aks.node_count_system
  mode                  = "System"
}
