output "network_out" {
  value = { for network in module.network : network.vnet.location => {
    vnet    = network.vnet
    subnets = network.subnets
  } }
}
