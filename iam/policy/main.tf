locals {
  environment = {
    random = random_string.random_num.result
  }
  resources = yamldecode(file("${path.module}/${var.domain}.yaml"))
  policy    = yamldecode(templatefile("${path.module}/policy.yaml", merge(local.resources, local.environment)))

  organization_bindings = flatten([
    for organization in local.policy.organizations : [
      for binding in organization.iamPolicy.bindings : [
        for member in binding.members : {
          org_id = organization.name
          role   = binding.role
          member = member
        }
      ]
    ]
  ])

  folder_bindings = flatten([
    for folder in local.policy.folders : [
      for binding in folder.iamPolicy.bindings : [
        for member in binding.members : {
          folder_id = folder.name
          role      = binding.role
          member    = member
        }
      ]
    ]
  ])

  project_bindings = flatten([
    for project in local.policy.projects : [
      for binding in project.iamPolicy.bindings : [
        for member in binding.members : {
          project_id = project.name
          role       = binding.role
          member     = member
        }
      ]
    ]
  ])
}

resource "google_organization_iam_member" "organization" {
  for_each = { for binding in local.organization_bindings : "${binding.org_id}/${binding.role}/${binding.member}" => binding }

  org_id = each.value.org_id
  role   = each.value.role
  member = each.value.member
}

resource "google_folder_iam_member" "folder" {
  for_each = { for binding in local.folder_bindings : "${binding.folder_id}/${binding.role}/${binding.member}" => binding }

  folder = each.value.folder_id
  role   = each.value.role
  member = each.value.member
}

resource "google_project_iam_member" "project" {
  for_each = { for binding in local.project_bindings : "${binding.project_id}/${binding.role}/${binding.member}" => binding }

  project = each.value.project_id
  role    = each.value.role
  member  = each.value.member
}