data "azurerm_subscription" "main" {
  
}

data "azurerm_subnet" "aks_subnet" {
  name                 = "${local.environment}-k8s"
  virtual_network_name = local.virtual_network_name
  resource_group_name  = "${local.virtual_network_name}-rg"
}

data "azurerm_container_registry" "acr" {
  provider            = azurerm.infrastructure_uk
  name                = var.acr_name
  resource_group_name = var.acr_resourcegroup_name
}