locals {

  regex_parent = "(?P<type>.*)/(?P<name>.*)"

  folders = flatten([
    for folder in try(var.config.folders, []) : [
      { folder = folder }
    ]
  ])

  projects = flatten([
    for project in try(var.config.projects, []) : { project = project }
  ])

  service_accounts = flatten([
    for project in try(var.config.projects, []) : [
      for service_account in try(project.serviceAccounts, []) : [
        { project = project, service_account = service_account }
      ]
    ]
  ])
}

module "organizations" {
  source   = "github.com/gcp-foundation/modules//resources/organization?ref=0.0.2"
  for_each = { for organization in var.config.organizations : organization.displayName => organization }

  domain = each.value.displayName
}

module "folders" {
  source   = "github.com/gcp-foundation/modules//resources/folder?ref=0.0.2"
  for_each = { for folder in var.config.folders : folder.displayName => folder }

  display_name = each.value.displayName
  parent       = module.organizations[regex(local.regex_parent, each.value.parent).name].name
}

module "projects" {
  source   = "github.com/gcp-foundation/modules//resources/project?ref=0.0.2"
  for_each = { for project in var.config.projects : project.displayName => project }

  name            = each.value.displayName
  folder          = module.folders[regex(local.regex_parent, each.value.parent).name].name
  services        = each.value.services
  billing_account = try(each.value.billingAccount, var.billing_account)
  labels          = try(each.value.labels, var.labels)
}

module "service_accounts" {
  source   = "github.com/gcp-foundation/modules//iam/service_account?ref=0.0.2"
  for_each = { for entry in local.service_accounts : entry.service_account.name => entry }

  project      = module.projects[each.value.project.displayName].project_id
  name         = each.value.service_account.name
  display_name = each.value.service_account.displayName
  description  = each.value.service_account.description
}

