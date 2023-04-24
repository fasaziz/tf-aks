resource "azurerm_resource_group" "default" {
  name     = local.cluster_resource_group_name
  location = local.location

  tags = local.common_tags
}

resource "azurerm_kubernetes_cluster" "default" {
  name                    = local.cluster_name
  location                = azurerm_resource_group.default.location
  resource_group_name     = azurerm_resource_group.default.name
  dns_prefix              = local.cluster_name
  private_cluster_enabled = false
  azure_policy_enabled    = local.azure_policy_enabled
  kubernetes_version      = var.kubernetes_version

  default_node_pool {
    name                         = "systempool1"
    min_count                    = 2
    max_count                    = 6
    enable_auto_scaling          = true
    max_pods                     = 150
    vm_size                      = "Standard_DS2_v2"
    zones                        = ["1", "2", "3"]
    enable_node_public_ip        = true
    only_critical_addons_enabled = true
    node_public_ip_prefix_id     = azurerm_public_ip_prefix.cluster_ip.id
    tags                         = local.common_tags
    vnet_subnet_id               = data.azurerm_subnet.aks_subnet.id
    orchestrator_version         = var.kubernetes_version
    node_labels                  = var.common_node_labels
  }

  identity {
    type = "SystemAssigned"
  }

  azure_active_directory_role_based_access_control {
    managed                = true
    admin_group_object_ids = var.admin_object_ids
  }

  network_profile {
    network_plugin    = "azure"
    network_mode      = "transparent"
    load_balancer_sku = "standard"
    outbound_type     = "loadBalancer"
  }

  dynamic "microsoft_defender" {
    for_each = local.defender_enabled ? [1] : []
    content {
      log_analytics_workspace_id = var.log_analytics_workspace_id
    }
  }

  tags = local.common_tags
}

resource "azurerm_kubernetes_cluster_node_pool" "linux-agents" {
  count                 = (var.max_node_count_linux > 0 || var.min_node_count_linux > 0) ? 1 : 0
  name                  = "linuxpool"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.default.id
  vm_size               = "Standard_DS2_v2"
  mode                  = "User"

  os_type               = "Linux"
  enable_node_public_ip = false
  vnet_subnet_id        = data.azurerm_subnet.aks_subnet.id
  orchestrator_version  = var.kubernetes_version
  max_pods              = 200
  zones                 = ["1", "2", "3"]
  enable_auto_scaling   = true
  max_count             = var.max_node_count_linux
  min_count             = var.min_node_count_linux
  node_labels           = merge(var.common_node_labels, var.linux_node_labels)

  tags = local.common_tags
}

resource "azurerm_kubernetes_cluster_node_pool" "datascience-agents" {
  count                 = (var.min_node_count_datascience > 0 || var.max_node_count_datascience > 0) ? 1 : 0
  name                  = "datascience"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.default.id
  vm_size               = "Standard_E2s_v3"
  mode                  = "User"

  os_type               = "Linux"
  enable_node_public_ip = false
  vnet_subnet_id        = data.azurerm_subnet.aks_subnet.id
  orchestrator_version  = var.kubernetes_version
  max_pods              = 30
  zones                 = ["1", "2", "3"]
  enable_auto_scaling   = true
  max_count             = var.max_node_count_datascience
  min_count             = var.min_node_count_datascience
  node_labels           = merge(var.common_node_labels, var.datascience_node_labels)

  tags = local.common_tags
}

resource "azurerm_kubernetes_cluster_node_pool" "tc_linuxpool" {
  count                 = (var.min_node_count_tc_agent_linux > 0 || var.max_node_count_tc_agent_linux > 0) ? 1 : 0
  name                  = "tclinuxpool"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.default.id
  vm_size               = "Standard_DS3_v2"
  mode                  = "User"

  os_type               = "Linux"
  enable_node_public_ip = false
  vnet_subnet_id        = data.azurerm_subnet.aks_subnet.id
  orchestrator_version  = var.kubernetes_version
  max_pods              = 30
  zones                 = ["1", "2", "3"]
  enable_auto_scaling   = true
  max_count             = var.max_node_count_tc_agent_linux
  min_count             = var.min_node_count_tc_agent_linux
  node_labels           = merge(var.common_node_labels, var.tc_agent_node_labels)

  tags                  = local.common_tags
}
