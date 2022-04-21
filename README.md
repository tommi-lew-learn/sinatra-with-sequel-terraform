# Sinatra with Sequel Terraform
This is a terraform project which provisions a infrastructure for deploying [Sinatra with Sequel](https://github.com/tommi-lew-learn/sinatra-with-sequel) to Google Cloud Platform (GCP). 

This was created as part of a GCP learning project. The goal was to deploy a simple web application with a database. And along the way, appreciate the differences between AWS and GCP.


## Local development environment

### Prerequisite
- [Terraform](https://www.terraform.io/)
  - You will need basic Terraform knowledge. Eg. Usage of `fmt`, `init`, `validate` and `apply` commands
- Create a service account on your GCP project
- Download the JSON key for the service account. There is likely a better (and safer) way to do this. I do not recommend that you put the key file in the project directory, to avoid committing the key by accident.
- Run `cp .secret.tfvars.template .secret.tfvars`. This file contains values that specific to your project.
- Update the values in `.secret.tfvars` accordingly.

### Terraform apply
Run `terraform apply -var-file="secret.tfvars"`
