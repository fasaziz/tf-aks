terraform {
  required_version = ">= 1.3.6"

  backend "azurerm" {}

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.37.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 2.32.0"
    }
  }
}

provider "azurerm" {
  features {}
}

provider "azurerm" {
  features {}
  alias           = "infrastructure_uk"
  subscription_id = "90640a6f-ec6c-4875-9351-c201b87702fb"
  client_id       = var.infra_uk_client_id
  client_secret   = var.infra_uk_client_secret
  tenant_id       = var.tenant_id
}

provider "azuread" {
  client_id     = var.client_id
  client_secret = var.client_secret
  tenant_id     = var.tenant_id
}

