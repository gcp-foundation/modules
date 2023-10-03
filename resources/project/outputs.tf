output "project_id" {
  value = google_project.project.project_id
}

output "number" {
  value = google_project.project.number
}

output "services" {
  value = var.services != [] ? google_project_services.service : []
}
