module "organization" {
  source = "./organization"
  domain = var.domain
}

module "folders" {
  source          = "./folders"
  organization_id = module.organization.organization_id
}

module "projects" {
  source          = "./projects"
  organization_id = module.organization.organization_id
}

module "service_accounts" {
  source          = "./service_accounts"
  organization_id = module.organization.organization_id
}
