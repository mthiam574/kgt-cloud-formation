variable "location" {
  description = "Région Azure"
  default     = "francecentral"
}

variable "resource_group" {
  description = "Resource Group"
  default     = "kgt-formation"
}

variable "app_name" {
  description = "Nom de l'application"
  default     = "kgt-app"
}

variable "registry_name" {
  description = "Nom du registre ACR"
  default     = "kgtformationregistry"
}
