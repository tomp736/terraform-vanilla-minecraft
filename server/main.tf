########### Variables ###########
variable "hcloud_token" {}
variable "username" {}
variable "sshkey" {}

########### Data ###########
data "template_file" "cloud-init-yaml" {
  template = file("${path.module}/cloud-init.yaml")
  vars = {
    username = var.username
    sshkey-admin = var.sshkey
  }
}

########### Providers ###########
provider "hcloud" {
  token = var.hcloud_token
}

########### Server ###########
resource "hcloud_volume_attachment" "main" {
  volume_id = hcloud_volume.volume1.id
  server_id = hcloud_server.server.id
  automount = true
}

resource "hcloud_server" "server" {
  name = "mc-docker"
  location = "fsn1"
  image = "ubuntu-18.04"
  backups = true
  server_type = "cx21"
  user_data = data.template_file.cloud-init-yaml.rendered
}

resource "hcloud_volume" "volume1" {
  location = "fsn1"
  name = "mcdata"
  size = 10
}
########### Output ###########
output "server_ipv4" {
  value = hcloud_server.server.ipv4_address
}
output "server_ipv6" {
  value = hcloud_server.server.ipv6_address
}