variable "cloud" {
  description = "Which public cloud is the network being deployed to?"
  type        = string
  default     = null
}

variable "network" {
  description = <<EOT
    Network topology described by an object. Example:

    ```
    {
        name           = somenetwork
        location       = deployment-region
        address_spaces = [192.168.100.0/24]
    }
    ```
EOT
  type        = any
  default     = {}
}

variable "labels_context" {
  description = "Context from the Pyrat Labels module"
  type        = string
  default     = ""
}
