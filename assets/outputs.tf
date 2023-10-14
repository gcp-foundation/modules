output "organization_id" {
  value = module.organization.organization_id
}

output "folders" {
  value = module.folders.search
}

output "projects" {
  value = module.projects.projects
}
