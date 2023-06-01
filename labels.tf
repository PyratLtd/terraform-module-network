module "labels" {
  source = "github.com/PyratLtd/terraform-module-labels.git?ref=main"

  context = var.labels_context
}
