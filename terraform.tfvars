region                        = "us-east-1"
number_of_az                  = "3"
saas_vpc_cidr                 = "10.10.0.0/16"
saas_public_subnet_cidr       = ["10.10.0.0/22", "10.10.4.0/22", "10.10.8.0/22"]
saas_private_app_subnet_cidr  = ["10.10.32.0/22", "10.10.36.0/22", "10.10.40.0/22"]
saas_private_data_subnet_cidr = ["10.10.64.0/22", "10.10.68.0/22", "10.10.72.0/22"]
environment                   = "test"