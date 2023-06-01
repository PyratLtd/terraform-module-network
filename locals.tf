locals {
  azure_network_config = {
    resource_group_name      = lookup(var.network, "resource_group_name", format("%s-rg", var.network.name))
    location                 = var.network.location
    name                     = var.network.name
    address_spaces           = lookup(var.network, "address_spaces", [for subnet in values(var.network.subnets) : subnet.prefix])
    dns_servers              = lookup(var.network, "dns_servers", [])
    subnet_prefixes          = [for subnet in values(var.network.subnets) : subnet.prefix]
    subnet_names             = [for subnet_key in keys(var.network.subnets) : subnet_key]
    subnet_service_endpoints = { for sk, sv in var.network.subnets : sk => lookup(sv, "service_endpoints", []) }
    subnet_delegation        = { for sk, sv in var.network.subnets : sk => lookup(sv, "delegations", []) }
  }
}
