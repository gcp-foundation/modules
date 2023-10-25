locals {
  organization_bindings = flatten([
    for organization in var.policy.organizations : [
      for binding in organization.iamPolicy.bindings : [
        for member in binding.members : {
          org_id = data.google.organization.organizations[organization.domain].org_id
          role   = binding.role
          member = member
        }
      ]
    ]
  ])

  # Need to add code to cope with missing folders object
  folder_bindings = flatten([
    for folder in var.policy.folders : [
      for binding in folder.iamPolicy.bindings : [
        for member in binding.members : {
          name   = folder.name
          role   = binding.role
          member = member
        }
      ]
    ]
  ])

  # Need to add code to cope with missing projects object
  project_bindings = flatten([
    for project in var.policy.projects : [
      for binding in project.iamPolicy.bindings : [
        for member in binding.members : {
          name   = project.name
          role   = binding.role
          member = member
        }
      ]
    ]
  ])
}

data "google_organization" "organization" {
  for_each = { for organization in var.policy.organizations : organization.domain => organization }

  domain = each.value.domain
}

resource "google_organization_iam_member" "organization" {
  for_each = { for binding in local.organization_bindings : "${binding.org_id}/${binding.role}/${binding.member}" => binding }

  org_id = each.value.org_id
  role   = each.value.role
  member = "serviceAccount:${var.members[each.value.member].email}"
}

resource "google_folder_iam_member" "folder" {
  for_each = { for binding in local.folder_bindings : "${binding.folder_id}/${binding.role}/${binding.member}" => binding }

  folder = var.resources.folders[each.value.name].folder_id
  role   = each.value.role
  member = "serviceAccount:${var.members[each.value.member].email}"
}

resource "google_project_iam_member" "project" {
  for_each = { for binding in local.project_bindings : "${binding.project_id}/${binding.role}/${binding.member}" => binding }

  project = var.resources.projects[each.value.name].project_id
  role    = each.value.role
  member  = "serviceAccount:${var.members[each.value.member].email}"
}
