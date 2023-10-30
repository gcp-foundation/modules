locals {
  org_roles = flatten([
    for organization in try(var.policy.organizations, []) : [
      for role in try(organization.roles, []) : {
        name         = role.name
        organization = organization.displayName
        title        = role.title
        description  = try(role.description, null)
        permissions  = role.includedPermissions
      }
    ]
  ])

  organization_bindings = flatten([
    for organization in try(var.policy.organizations, []) : [
      for binding in try(organization.iamPolicy.bindings, []) : [
        for member in binding.members : {
          name   = organization.displayName
          role   = binding.role
          member = member
        }
      ]
    ]
  ])

  folder_bindings = flatten([
    for folder in try(var.policy.folders, []) : [
      for binding in try(folder.iamPolicy.bindings, []) : [
        for member in try(binding.members, []) : {
          name   = folder.displayName
          role   = binding.role
          member = member
        }
      ]
    ]
  ])

  project_bindings = flatten([
    for project in try(var.policy.projects, []) : [
      for binding in try(project.iamPolicy.bindings, []) : [
        for member in try(binding.members, []) : {
          name   = project.displayName
          role   = binding.role
          member = member
        }
      ]
    ]
  ])

  service_account_bindings = flatten([
    for service_account in try(var.policy.service_accounts, []) : [
      for binding in try(service_account.iamPolicy.bindings, []) : [
        for member in try(binding.members, []) : {
          name   = service_account.displayName
          role   = binding.role
          member = member
        }
      ]
    ]
  ])
}

resource "google_organization_iam_custom_role" "organization" {
  for_each = { for role in local.org_roles : role.name => role }

  role_id     = each.value.name
  org_id      = var.resources.organizations[each.value.organization].org_id
  title       = each.value.title
  description = each.value.description
  permissions = each.value.permissions
}

resource "google_organization_iam_member" "organization" {
  for_each = { for binding in local.organization_bindings : "${binding.name}/${binding.role}/${binding.member}" => binding }

  org_id = var.resources.organizations[each.value.name].org_id
  role   = each.value.role
  member = "serviceAccount:${var.members[each.value.member].email}"
}

resource "google_folder_iam_member" "folder" {
  for_each = { for binding in local.folder_bindings : "${binding.name}/${binding.role}/${binding.member}" => binding }

  folder = var.resources.folders[each.value.name].folder_id
  role   = each.value.role
  member = "serviceAccount:${var.members[each.value.member].email}"
}

resource "google_project_iam_member" "project" {
  for_each = { for binding in local.project_bindings : "${binding.name}/${binding.role}/${binding.member}" => binding }

  project = var.resources.projects[each.value.name].project_id
  role    = each.value.role
  member  = "serviceAccount:${var.members[each.value.member].email}"
}

resource "google_service_account_iam_member" "service_account" {
  for_each = { for binding in local.service_account_bindings : "${binding.name}/${binding.role}/${binding.member}" => binding }

  service_account_id = var.resources.service_accounts[each.value.name].name
  role               = each.value.role
  member             = "serviceAccount:${var.members[each.value.member].email}"
}
