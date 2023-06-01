module "az" {
  source = "../."

  cloud          = "azure"
  labels_context = module.labels.context

  network = {
    name           = module.labels.id
    location       = "uksouth"
    address_spaces = ["192.168.100.0/24"]
    dns_zones = [
      "pyrat.co",
      "pyrat.uk"
    ]
    subnets = {
      main = {
        prefix = "192.168.100.0/25"
        service_endpoints = [
          "Microsoft.Sql"
        ]
      }
      postgres = {
        prefix = "192.168.100.128/25"
        delegations = [
          {
            name = "postgres"
            service_delegation = {
              name = "Microsoft.DBforPostgreSQL/flexibleServers"
              actions = [
                "Microsoft.Network/virtualNetworks/subnets/join/action"
              ]
            }
          }
        ]
      }
    }
  }
}
