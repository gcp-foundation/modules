module "organization" {
  source = "organization"
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
