locals {  
  country_code                 = var.country_codes[var.tenant]
  location                     = var.locations[var.short_location]
  environment                  = var.environments[var.short_environment]
  cluster_name                 = "${var.short_location}-${local.country_code}-${var.short_environment}-aks"
  cluster_resource_group_name  = "${var.short_location}-${local.country_code}-${var.short_environment}-${var.purpose}-aks-rg"
  cluster_ip_name              = "${var.short_location}-${local.country_code}-${var.short_environment}-${var.purpose}-aks-ip"
  cluster_ip_resource_group    = "${var.short_location}-${local.country_code}-${var.short_environment}-${var.purpose}-aksip-rg"  
  ad_application_name          = "${var.short_location}-${local.country_code}-${var.short_environment}-${var.purpose}-aks-mid"
  virtual_network_name         = "${var.short_location}-${local.country_code}-${var.short_environment}-core-vnet"
  vnet_environment             = var.vnet_environments[local.environment]
  dns_zone_resource_group_name = "uksouth-infrastructure-rg"
  common_tags = {
    purpose        = var.purpose
    env            = local.environment
    location       = local.location
    country_code   = local.country_code
    run_time_model = "24/7"
    latest_ticket  = "https://capitalontap.atlassian.net/browse/DVOP-447"
    exposure       = "internal"
    domain         = "core"
  }
  defender_enabled = var.defender_enabled[var.short_environment]
  azure_policy_enabled = var.azure_policy_enabled[var.short_environment]
}