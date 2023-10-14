output "display_name" {
  value = google_project.project.display_name
}

output "project_id" {
  value = google_project.project.project_id
}

output "number" {
  value = google_project.project.number
}

output "folder_id" {
  value = google_project.project.project_id
}

output "services" {
  value = google_project_service.service
}

output "project" {
  value = google_project.project
}

