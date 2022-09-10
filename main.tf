module "network" {
  source = "./network"

  environment = var.environment
  number_of_az = var.number_of_az
  region = var.region
  saas_private_app_subnet_cidr = var.saas_private_app_subnet_cidr
  saas_private_data_subnet_cidr = var.saas_private_data_subnet_cidr
  saas_public_subnet_cidr = var.saas_public_subnet_cidr
  saas_vpc_cidr = var.saas_vpc_cidr
}

module "app" {
  source = "./app"
  container_name = "app"
  environment = var.environment
  security_group_id = module.network.public_sg_id
  subnet_ids = module.network.public_subnet_ids
  desired_count = "1"
  vpc_id = module.network.vpc_id
}