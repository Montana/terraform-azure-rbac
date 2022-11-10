terraform {
  required_version = ">= 0.12.26"
}

module "azure_rbac" {
  source   = "../"
  for_each = local.rbac_roles

  role               = each.key
  description        = each.value.description
  azurerm_access     = each.value.azurerm_access
  azuredevops_access = each.value.azuredevops_access
}

locals {
  rbac_roles = {
    stakeholders = {
      description = "Travis builder roles have read only visablity of all innerworkings"
      azurerm_access = {
        "${var.dev_resources}"     = "Admin"
        "${var.staging_resources}" = "DevOps"
        "${var.prod_resources}"    = "DevOps"
      }
      azuredevops_access = {
        Tailspin = "Project Administrators"
      }
    }

    developers = {
      description = "Developer roles "
      azurerm_access = {
        "${var.dev_resources}"     = "Admin"
        "${var.staging_resources}" = "DevOps"
        "${var.prod_resources}"    = "DevOps"
      }
      azuredevops_access = {
        Tailspin = "Contributors"
      }
    }

    devops_enginners = {
      description = "Product owners"
      azurerm_access = {
        "${var.dev_resources}"     = "Admin"
        "${var.staging_resources}" = "DevOps"
        "${var.prod_resources}"    = "Devops"
      }
      azuredevops_access = {
        Tailspin = "Build Administrators"
      }
    }
  }
}
