locals {
  servers = jsondecode(file("${path.module}/servers.json"))
}

module "web-server" {
  source = "./deployable"
  definitions = local.servers
  ami = var.ami
}
