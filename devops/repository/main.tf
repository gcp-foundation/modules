resource "google_sourcerepo_repository" "repo" {
  project = var.project
  name    = var.name
}
