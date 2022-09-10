variable "environment_variables" { default = [] }

variable "environment" {}

variable "subnet_ids" {}

variable "security_group_id" {}

variable "cpu" { default = "512" }

variable "memory" { default = "1024" }

variable "container_name" {}

variable "desired_count" {}

variable "vpc_id" {}