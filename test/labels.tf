module "labels" {
  source = "github.com/PyratLtd/terraform-module-labels.git?ref=main"

  name         = "network"
  organisation = "Pyrat"
  location     = "uksouth"
  environment  = "prod"
  stage        = "prod"
}
