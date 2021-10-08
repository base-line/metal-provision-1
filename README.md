# metal-provision-1
Provision servers on Equinix Metal

# Pre-requiments
- [terraform](https://www.terraform.io/downloads.html) 
- [vagrant](https://www.vagrantup.com/downloads) 
- [virtualbox](https://www.virtualbox.org/)

## How to consume
```bash
git clone https://github.com/base-line/metal-provision-1
cd metal-provision-1
```

## Using metal-cli tool

To start using metal-cli we'll need to fill in `config/metal.yaml-template` with credentials

Once the VM is up and running the `metal cli` will be installed and configure automatically.

```bash
vagrant up
vagrant ssh
```

Create the instance 
```bash
vagrant@metal-cli:~$ metal device create \
  --hostname tf-ubuntu \
  --plan t1.small.x86 \
  --facility ams1 \
  --operating-system ubuntu_18_04 \
  --project-id <project-id>
```

## Using Terraform

create infrastructure 

```bash
terraform init
terraform apply
```

delete infrastructure
```bash
terraform destroy
```
