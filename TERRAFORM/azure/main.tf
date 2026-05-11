terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}
}

# Récupérer le Resource Group existant
data "azurerm_resource_group" "kgt" {
  name = var.resource_group
}

# Récupérer le registre ACR existant
data "azurerm_container_registry" "kgt" {
  name                = var.registry_name
  resource_group_name = var.resource_group
}

# Déployer le conteneur ACI
resource "azurerm_container_group" "kgt_app" {
  name                = "${var.app_name}-tf"
  location            = data.azurerm_resource_group.kgt.location
  resource_group_name = data.azurerm_resource_group.kgt.name
  os_type             = "Linux"
  ip_address_type     = "Public"

  image_registry_credential {
    server   = data.azurerm_container_registry.kgt.login_server
    username = data.azurerm_container_registry.kgt.admin_username
    password = data.azurerm_container_registry.kgt.admin_password
  }

  container {
    name   = var.app_name
    image  = "${data.azurerm_container_registry.kgt.login_server}/${var.app_name}:v1.0"
    cpu    = "1"
    memory = "1"

    ports {
      port     = 8080
      protocol = "TCP"
    }
  }

  tags = {
    Env = "formation"
  }
}
