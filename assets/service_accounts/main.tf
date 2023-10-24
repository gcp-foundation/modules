data "google_cloud_asset_resources_search_all" "service_accounts" {
  provider = google-beta

  scope = "organizations/${var.organization_id}"
  asset_types = [
    "iam.googleapis.com/ServiceAccount"
  ]
  query = "state:ENABLED"
}

locals {

  # Might need to enhance this later
  match = "\\/\\/iam\\.googleapis\\.com\\/projects\\/(?P<project>[^\\/]*)\\/serviceAccounts\\/(?P<name>[^@]*)@(?P<scope>[^.]*)\\.(?P<domain>.*)"

  service_accounts = {
    for service_account in data.google_cloud_asset_resources_search_all.service_accounts.results :
    regex(local.match, service_account.name).name => {
      name         = regex(local.match, service_account.name).name,
      project      = regex(local.match, service_account.name).project,
      scope        = regex(local.match, service_account.name).scope,
      domain       = regex(local.match, service_account.name).domain,
      description  = service_account.description,
      display_name = service_account.display_name
    }
  }
}


