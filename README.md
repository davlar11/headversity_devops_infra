This creates a basic infra with vpc, some subnets and a set of fargate ecs resources ready to be updated by the headversity_devops_app repo.

If this were started from scratch, the following steps would need to be followed : 

- Create an aws account
- Create an iam user with programmatic access (and rights to create resources)
- Put the iam user's access key and secret key in the github action secrets (look for the two secrets in the yml file for the action)
- Create an s3 bucket to properly configure terraform backend (look at backend.tf to get an idea. For more detail see [here](https://www.terraform.io/language/settings/backends/s3))
- Change backend.tf with relevant changes based on bucket created
- Run the github action jobs

Once this is done, the foundation is layed for running the github action found in headversity_devops_app