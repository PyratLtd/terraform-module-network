# Resource Group
resource "azurerm_resource_group" "this" {
  for_each = var.cloud == "azure" ? { enabled = true } : {}

  name     = local.azure_network_config.resource_group_name
  location = local.azure_network_config.location
  tags     = module.labels.tags
}

# Network and Subnets
module "azure_network" {
  for_each = var.cloud == "azure" ? { enabled = true } : {}

  depends_on = [azurerm_resource_group.this]

  source = "github.com/Azure/terraform-azurerm-network.git?ref=5.2.0"

  use_for_each             = true
  resource_group_name      = azurerm_resource_group.this["enabled"].name
  vnet_name                = local.azure_network_config.name
  address_spaces           = local.azure_network_config.address_spaces
  dns_servers              = local.azure_network_config.dns_servers
  subnet_prefixes          = local.azure_network_config.subnet_prefixes
  subnet_names             = local.azure_network_config.subnet_names
  subnet_service_endpoints = local.azure_network_config.subnet_service_endpoints
  subnet_delegation        = local.azure_network_config.subnet_delegation

  tags = module.labels.tags
}

# DNS Zones
resource "azurerm_dns_zone" "this" {
  for_each = var.cloud == "azure" ? { for k in lookup(var.network, "dns_zones", []) : (replace(k, ".", "-")) => k } : {}

  name                = each.value
  resource_group_name = azurerm_resource_group.this["enabled"].name
  tags                = module.labels.tags
}
