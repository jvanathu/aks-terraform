resource "azurerm_kubernetes_cluster" "aks" {
  name                = "aks-${var.cluster_name}-${var.environment}"
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = "${var.cluster_name}-${var.environment}"

  default_node_pool {
    name            = "default"
    node_count      = var.node_count
    vm_size         = var.node_vm_size
    vnet_subnet_id  = var.aks_subnet_id
    // Optionally, add other configurations as needed
  }

  network_profile {
    network_plugin     = "azure"
    service_cidr       = var.service_cidr
    dns_service_ip     = var.dns_service_ip
    docker_bridge_cidr = var.docker_bridge_cidr
    // Enable private cluster
    load_balancer_sku = "standard"
    outbound_type     = "userDefinedRouting"
  }

  private_cluster_enabled = true

  identity {
    type = "SystemAssigned"
  }

  tags = {
    environment = var.environment
  }
}
