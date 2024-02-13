
module "network" {
  source      = "./modules/network"
  for_each    = var.network
  environment = var.environment
  region_name_mapper = var.region_name_mapper
  network = {
    location                = each.key
    address_space           = each.value.address_space
    subnet_address_prefixes = each.value.subnet_address_prefixes
    nat_gateway             = each.value.nat_gateway
  }
  tags = var.tags
}

