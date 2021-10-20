data "template_file" "user_data" {
  template = file("bootstrap/pkg.sh")
}

module "key" {
  source     = "git::github.com/andrewpopa/terraform-metal-project-ssh-key"
  project_id = var.project_id
}

module "device" {
  source = "git::github.com/andrewpopa/terraform-metal-device.git"

  hostname            = "tf-ubuntu"
  plan                = "t1.small.x86"
  facilities          = ["ams1"]
  operating_system    = "ubuntu_18_04"
  billing_cycle       = "hourly"
  project_id          = var.project_id
  project_ssh_key_ids = [module.key.id]
}

module "device_user_data" {
  source = "git::github.com/andrewpopa/terraform-metal-device.git"

  hostname            = "tf-ubuntu-userdata"
  plan                = "t1.small.x86"
  facilities          = ["ams1"]
  operating_system    = "ubuntu_18_04"
  billing_cycle       = "hourly"
  project_id          = var.project_id
  project_ssh_key_ids = [module.key.id]
  user_data           = data.template_file.user_data.rendered
}

module "ip" {
  source = "git::git@github.com:andrewpopa/terraform-metal-reserved-ip-block.git"
  project_id  = var.project_id
  quantity    = var.quantity
  facility    = var.facility
  description = var.description
}

module "device_ip" {
  source = "git::github.com/andrewpopa/terraform-metal-device.git"
  hostname            = "tf-ubuntu-userdata"
  plan                = "t1.small.x86"
  facilities          = ["ams1"]
  operating_system    = "ubuntu_18_04"
  billing_cycle       = "hourly"
  project_id          = var.project_id
  project_ssh_key_ids = [module.key.id]
  user_data           = data.template_file.user_data.rendered
}

resource "metal_ip_attachment" "first_address_assignment" {
  device_id = module.device_ip.id
  cidr_notation = join("/", [cidrhost(module.ip.cidr_notation, 0), "32"])
}