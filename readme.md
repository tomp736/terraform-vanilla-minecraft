sudo pamac install terraform

terraform -v

terraform init

terraform apply -var-file=secrets.tfvars

terraform destroy -var-file=secrets.tfvars