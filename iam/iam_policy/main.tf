locals {
  regex_role = "(?P<type>.*)\\/(?P<name>.*)"

  org_roles = flatten([
    for policy in var.policies : [
      for organization in try(policy.organizations, []) : [
        for role in try(organization.roles, []) : {
          name         = role.name
          organization = organization.displayName
          title        = role.title
          description  = try(role.description, null)
          permissions  = role.permissions
        }
      ]
    ]
  ])

  prj_roles = flatten([
    for policy in var.policies : [
      for project in try(policy.projects, []) : [
        for role in try(project.roles, []) : {
          name        = role.name
          project     = project.displayName
          title       = role.title
          description = try(role.description, null)
          permissions = role.permissions
        }
      ]
    ]
  ])

  organization_bindings = flatten([
    for policy in var.policies : [
      for organization in try(policy.organizations, []) : [
        for binding in try(organization.iamPolicy.bindings, []) : [
          for member in binding.members : {
            name   = organization.displayName
            role   = binding.role
            member = member
          }
        ]
      ]
    ]
  ])

  folder_bindings = flatten([
    for policy in var.policies : [
      for folder in try(policy.folders, []) : [
        for binding in try(folder.iamPolicy.bindings, []) : [
          for member in try(binding.members, []) : {
            name   = folder.displayName
            role   = binding.role
            member = member
          }
        ]
      ]
    ]
  ])

  project_bindings = flatten([
    for policy in var.policies : [
      for project in try(policy.projects, []) : [
        for binding in try(project.iamPolicy.bindings, []) : [
          for member in try(binding.members, []) : {
            name   = project.displayName
            role   = binding.role
            member = member
          }
        ]
      ]
    ]
  ])

  service_account_bindings = flatten([
    for policy in var.policies : [
      for service_account in try(policy.service_accounts, []) : [
        for binding in try(service_account.iamPolicy.bindings, []) : [
          for member in try(binding.members, []) : {
            name   = service_account.displayName
            role   = binding.role
            member = member
          }
        ]
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

resource "google_project_iam_custom_role" "project" {
  for_each = { for role in local.org_roles : role.name => role }

  role_id     = each.value.name
  project     = var.resources.projects[each.value.project].project_id
  title       = each.value.title
  description = each.value.description
  permissions = each.value.permissions
}

resource "google_organization_iam_member" "organization" {
  for_each = { for binding in local.organization_bindings : "${binding.name}/${binding.role}/${binding.member}" => binding }

  org_id = var.resources.organizations[each.value.name].org_id
  role   = regex(local.regex_role, each.value.role).type == "roles" ? each.value.role : google_organization_iam_custom_role.organization[regex(local.regex_role, each.value.role).name].name
  member = "serviceAccount:${var.members[each.value.member].email}"

  depends_on = [google_organization_iam_custom_role.organization]
}

resource "google_folder_iam_member" "folder" {
  for_each = { for binding in local.folder_bindings : "${binding.name}/${binding.role}/${binding.member}" => binding }

  folder = var.resources.folders[each.value.name].folder_id
  role   = regex(local.regex_role, each.value.role).type == "roles" ? each.value.role : google_organization_iam_custom_role.organization[regex(local.regex_role, each.value.role).name].name
  member = "serviceAccount:${var.members[each.value.member].email}"

  depends_on = [google_organization_iam_custom_role.organization]
}

resource "google_project_iam_member" "project" {
  for_each = { for binding in local.project_bindings : "${binding.name}/${binding.role}/${binding.member}" => binding }

  project = var.resources.projects[each.value.name].project_id
  role    = regex(local.regex_role, each.value.role).type == "roles" ? each.value.role : google_organization_iam_custom_role.organization[regex(local.regex_role, each.value.role).name].name
  member  = "serviceAccount:${var.members[each.value.member].email}"

  depends_on = [google_organization_iam_custom_role.organization]
}

resource "google_service_account_iam_member" "service_account" {
  for_each = { for binding in local.service_account_bindings : "${binding.name}/${binding.role}/${binding.member}" => binding }

  service_account_id = var.resources.service_accounts[each.value.name].name
  role               = regex(local.regex_role, each.value.role).type == "roles" ? each.value.role : google_organization_iam_custom_role.organization[regex(local.regex_role, each.value.role).name].name
  member             = "serviceAccount:${var.members[each.value.member].email}"

  depends_on = [google_organization_iam_custom_role.organization]
}
