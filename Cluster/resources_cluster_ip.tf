resource "azurerm_resource_group" "cluster_ip" {
  name     = local.cluster_ip_resource_group
  location = local.location

  tags = local.common_tags
}

resource "azurerm_public_ip_prefix" "cluster_ip" {
  name                = local.cluster_ip_name
  location            = local.location
  resource_group_name = azurerm_resource_group.cluster_ip.name
  zones               = ["1", "2", "3"]
  prefix_length       = 30

  tags = local.common_tags

  lifecycle {
    ignore_changes = [
      tags,
    ]
  }
}