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
  volume_id = hcloud_volume.mcdata.id
  server_id = hcloud_server.mcserver.id

  provisioner "file" {
    source        = "mcserver/setup_volume.sh"
    destination   = "/tmp/setup_volume.sh"
    connection {
      host        = hcloud_server.mcserver.ipv4_address
      user        = var.username
      private_key = file("~/.ssh/id_rsa")
    }
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/setup_volume.sh",
      "sudo /tmp/setup_volume.sh \"/dev/sdb\" \"/mcdata\""
    ]
    connection {
      host        = hcloud_server.mcserver.ipv4_address
      user        = var.username
      private_key = file("~/.ssh/id_rsa")
    }
  }
}

resource "hcloud_server" "mcserver" {
  name = "mc-server"
  location = "fsn1"
  image = "ubuntu-18.04"
  backups = true
  server_type = "cx21"
  user_data = data.template_file.cloud-init-yaml.rendered

  ##### emit ipv4 for scripts ######
  provisioner "local-exec" {
    command = "echo ${hcloud_server.mcserver.ipv4_address} > .serverassets/ipv4_address"
  }
}

resource "hcloud_volume" "mcdata" {
  location = "fsn1"
  name = "mc-data"
  size = 10
}
########### Output ###########
output "server_ipv4" {
  value = hcloud_server.mcserver.ipv4_address
}
output "server_ipv6" {
  value = hcloud_server.mcserver.ipv6_address
}