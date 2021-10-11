data "template_file" "user_data" {
  template = file("bootstrap/pkg.sh")
}

module "key" {
  source     = "github.com/andrewpopa/terraform-metal-project-ssh-key"
  project_id = var.project_id
}

module "device" {
  source = "github.com/andrewpopa/terraform-metal-device.git"

  hostname            = "tf-ubuntu"
  plan                = "t1.small.x86"
  facilities          = ["ams1"]
  operating_system    = "ubuntu_18_04"
  billing_cycle       = "hourly"
  project_id          = var.project_id
  project_ssh_key_ids = [module.key.id]
}

module "device_user_data" {
  source = "github.com/andrewpopa/terraform-metal-device.git"

  hostname            = "tf-ubuntu-userdata"
  plan                = "t1.small.x86"
  facilities          = ["ams1"]
  operating_system    = "ubuntu_18_04"
  billing_cycle       = "hourly"
  project_id          = var.project_id
  project_ssh_key_ids = [module.key.id]
  user_data           = data.template_file.user_data.rendered
}