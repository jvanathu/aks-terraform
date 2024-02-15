
module "network" {
  source             = "./modules/network"
  for_each           = var.network
  environment        = var.environment
  region_name_mapper = var.region_name_mapper
  network = {
    location                = each.key
    address_space           = each.value.address_space
    subnet_address_prefixes = each.value.subnet_address_prefixes
    nat_gateway             = each.value.nat_gateway
  }
  tags = var.tags
}


module "aks" {
  source             = "./modules/aks"
  for_each           = var.aks
  environment        = var.environment
  region_name_mapper = var.region_name_mapper
  aks = {
    location                = each.key
    node_count = each.value.node_count
    vm_size = each.value.vm_size
        node_count_system = each.value.node_count_system
    vm_size_system = each.value.vm_size_system
  }
  tags = var.tags
}