variable "short_location" {
  description = "location the resource is to be deployed to"
  type        = string
  default     = "uks"
}

variable "locations" {
  description = "Short location resolves to a region for the resources"
  type        = map(any)
  default = {
    "uks"  = "uksouth"
    "ukw"  = "ukwest"
    "eus2" = "eastus2"
    "wus2" = "westus2"
  }
}

variable "short_environment" {
  description = "environment to deploy the resource"
  type        = string
  default     = "dev"
}

variable "environments" {
  description = "environment name for the vnet"
  type        = map(string)
  default = {
    "shared" = "shared"
    "infra"  = "infrastructure"
    "pro"    = "production"
    "pre"    = "preproduction"
    "dev"    = "development"
    "snb"    = "sandbox"
    "ci"     = "ci"
  }
}

variable "vnet_environments" {
  description = "environment name for the vnet"
  type        = map(string)
  default = {
    "shared"         = "shared"
    "infrastructure" = "infrastructure"
    "production"     = "production"
    "preproduction"  = "preproduction"
    "development"    = "development"
    "sandbox"        = "sandbox"
    "ci"             = "playground"
  }
}

variable "purpose" {
  description = "purpose of the resource"
  type        = string
  default     = "base"
}

variable "subscription_id" {
  type        = string
  description = "subscription id for the resource deployment"
}

variable "client_id" {
  type        = string
  description = "client id for the service principal"
}

variable "client_secret" {
  type        = string
  description = "client password for the service principal"
  sensitive   = true
}

variable "infra_uk_client_id" {
  type        = string
  description = "client id for the Infrastructure UK service principal"
}

variable "infra_uk_client_secret" {
  type        = string
  description = "client password for the Infrastructure UK  service principal"
  sensitive   = true
}

variable "tenant_id" {
  type        = string
  description = "tenant for the resources"
}

variable "country_codes" {
  description = "tenant to deploy the resource for resource name"
  type        = map(any)
  default = {
    "WW" = "ww"
    "UK" = "uk"
    "US" = "us"
  }
}

variable "tenant" {
  type        = string
  description = "which deployment tenant is this being pushed to"
}

variable "common_node_labels" {
  description = "(Optional) A mapping of labels to assign to the node pools"
  type        = map(string)
  default = {
    created-by = "devops"
    managed-by = "terraform"
  }
}

variable "system_node_labels" {
  type    = map(string)
  default = {}
}

variable "linux_node_labels" {
  type    = map(string)
  default = {}
}

variable "datascience_node_labels" {
  type    = map(string)
  default = {}
}

variable "tc_agent_node_labels" {
  type = map(string)
  default = {
    app = "tc-linux-agent"
  }
}

variable "acr_name" {
  type        = string
  description = "name of the azure container registry"
  default     = "capitalontappg"
}

variable "acr_resourcegroup_name" {
  type        = string
  description = "resource group name of the azure container registry"
  default     = "cot-k8s-playground"
}

variable "min_node_count_linux" {
  description = "The minimum number of nodes for the Linux agents cluster"
  type        = number
  default     = 3
  validation {
    condition = (
      var.min_node_count_linux >= 0 &&
      var.min_node_count_linux <= 30
    )
    error_message = "Must be between 0 and 30."
  }
}

variable "min_node_count_datascience" {
  description = "The minimum number of nodes for the Data Science agents cluster"
  type        = number
  default     = 0
  validation {
    condition = (
      var.min_node_count_datascience >= 0 &&
      var.min_node_count_datascience <= 30
    )
    error_message = "Must be between 0 and 30."
  }
}

variable "max_node_count_linux" {
  description = "The maximum number of nodes for the Linux agents cluster"
  type        = number
  default     = 30
  validation {
    condition = (
      var.max_node_count_linux >= 0 &&
      var.max_node_count_linux <= 30
    )
    error_message = "Must be between 0 and 30."
  }
}

variable "max_node_count_datascience" {
  description = "The maximum number of nodes for the Data Science agents cluster"
  type        = number
  default     = 0
  validation {
    condition = (
      var.max_node_count_datascience >= 0 &&
      var.max_node_count_datascience <= 30
    )
    error_message = "Must be between 0 and 30."
  }
}

variable "min_node_count_tc_agent_linux" {
  description = "The minimum number of nodes for the Linux agents cluster"
  type        = number
  default     = 0
  validation {
    condition = (
      var.min_node_count_tc_agent_linux >= 0 &&
      var.min_node_count_tc_agent_linux <= 30
    )
    error_message = "Must be between 0 and 30."
  }
}

variable "max_node_count_tc_agent_linux" {
  description = "The maximum number of nodes for the Linux agents cluster"
  type        = number
  default     = 0
  validation {
    condition = (
      var.max_node_count_tc_agent_linux >= 0 &&
      var.max_node_count_tc_agent_linux <= 30
    )
    error_message = "Must be between 0 and 30."
  }
}

variable "log_analytics_workspace_id" {
  type    = string
  default = null
}

variable "defender_enabled" {
  type = map(string)
  default = {
    "ci"             = false
    "dev"            = true
    "pre"            = true
    "infra"          = true
    "shared"         = true
    "pro"            = true
  }
}

# This is currently set to match what has been configured
# outside of Terraform (by the security team).
variable "azure_policy_enabled" {
  type = map(string)
  default = {
    "ci"             = false
    "dev"            = false
    "pre"            = false
    "infra"          = false
    "shared"         = true
    "pro"            = false
  }
}

variable "kubernetes_version" {
  default = "1.25.5"
}

variable "admin_object_ids" {
  type    = list(string)
  default = ["5fd66b4c-9ea2-43ef-99ed-57949fbd4a7b"]
}
