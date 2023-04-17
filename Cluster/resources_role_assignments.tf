# POD MANAGED IDENTITY REQUIREMENT
resource "azurerm_role_assignment" "aks_managed_identiy_operator" {
  scope                = "${data.azurerm_subscription.main.id}/resourcegroups/${azurerm_kubernetes_cluster.default.node_resource_group}"
  role_definition_name = "Managed Identity Operator"
  principal_id         = azurerm_kubernetes_cluster.default.kubelet_identity[0].object_id
}

# POD MANAGED IDENTITY REQUIREMENT
resource "azurerm_role_assignment" "aks_virtual_machine_contributor" {
  scope                = "${data.azurerm_subscription.main.id}/resourcegroups/${azurerm_kubernetes_cluster.default.node_resource_group}"
  role_definition_name = "Virtual Machine Contributor"
  principal_id         = azurerm_kubernetes_cluster.default.kubelet_identity[0].object_id
}

resource "azurerm_role_assignment" "aks_to_vnet" {
  scope                = data.azurerm_subnet.aks_subnet.id
  role_definition_name = "Network Contributor"
  principal_id         = azurerm_kubernetes_cluster.default.identity[0].principal_id
}

resource "azurerm_role_assignment" "acrpull_role" {
  provider             = azurerm.infrastructure_uk
  scope                = data.azurerm_container_registry.acr.id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_kubernetes_cluster.default.kubelet_identity[0].object_id
}