output "display_name" {
  value = google_project.project.display_name
}

output "project_id" {
  value = google_project.project.project_id
}

output "number" {
  value = google_project.project.number
}

output "services" {
  value = google_project_service.service
}

output "project" {
  value = google_project.project
}

              + create_time     = "2023-10-05T08:07:18.441Z"
              + display_name    = "devops"
              + folder_id       = "223235992948"
              + id              = "folders/223235992948"
              + lifecycle_state = "ACTIVE"
              + name            = "folders/223235992948"
              + parent          = "organizations/715048305958"
              + timeouts        = null
