########### Variables ###########
variable "hcloud_token" {}
variable "username" {}
variable "sshkey_location" {}

########### Data ###########
data "template_file" "sshkey" {
  template = file(var.sshkey_location)
}

########### Modules ###########
module "mcserver"{
  source = "./mcserver"
  hcloud_token = var.hcloud_token
  username = var.username
  sshkey = data.template_file.sshkey.rendered
}

########### Output ###########
output "server_ipv4" {
  value = module.mcserver.server_ipv4
}

output "server_ipv6" {
  value = module.mcserver.server_ipv6
}