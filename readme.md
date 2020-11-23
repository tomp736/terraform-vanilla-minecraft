# Requirements

1. Hetzner Account
2. Terraform
3. Patience

## Steps outlined as done on manjaro.

### Install Terraform

> sudo pamac install terraform

### Clone repository to local.

> git clone https://github.com/tomp736/terraform-minecraft.git

### Create secrets.tfvars and populate with hcould_token.

> hcloud_token = "------- token ---------"

### Run Terraform Init

> terraform init

### To create server

> terraform apply -var-file=secrets.tfvars

### To destroy server

> terraform destroy -var-file=secrets.tfvars