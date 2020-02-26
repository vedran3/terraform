##
## main.tf - defines resources that are 
## used by other TF scripts within modules directory.

## grab the  state configuration for shared subnets infrastructure
data "terraform_remote_state" "shared_networking" {
  backend = "azurerm"

  config {
    resource_group_name  = "myapp01_tfstate_0"
    storage_account_name = "myapp01tfstatede"
    container_name       = "tfstate"
    key                  = "nonprod/myapp01/component1/myapp01-de-0.tfstate"
  }
}

locals {
  myapp01_subnet_id  = "${data.terraform_remote_state.shared_networking.myapp01_subnet_id}"
}

module "myapp01_dev_resource_group" {
  source             = "git::ssh://git@yourRepoURL.com/terraform.git?ref=master//resource_group"

  app_name           = "${var.app_name}"
  app_code           = "${var.app_code}"
  location           = "${var.location}"
  app_environment    = "${var.environment}"
  compliance         = "${var.compliance}"
  index              = "${var.index}"
  cost_center_number = "${var.cost_center_number}"
}

module "myapp01_dev_availability_set" {
  source              = "git::ssh://git@yourRepoURL.com/terraform.git?ref=master//availability_set"

  app_name            = "${var.app_name}"
  app_code            = "${var.app_code}"
  app_environment     = "${var.environment}"
  compliance          = "${var.compliance}"
  resource_group_name = "${module.myapp01_dev_resource_group.resource_group_name}"
  index               = "${var.index}"
}

# Cloud Init
data "template_file" "cloud-init" {
  template = "${file("${path.module}/cloud-init.yaml")}"

    vars {
      sudoer_list = "${var.sudoer_list}"
    }
}

## declare the vm-scaleset
module "myapp01_dev_vmss" {
  source                     = "git::ssh://git@yourRepoURL.com/terraform.git?ref=master//autoscaling_vmss"

  resource_group             = "${module.myapp01_dev_resource_group.resource_group_name}"
  image_name                 = "${var.image_name}"
  image_resource_group       = "${var.image_resource_group}"
  resource_prefix            = "${var.app_code}-${var.app_name}-${var.envcode}"
  vm_custom_data             = "${data.template_file.cloud-init.rendered}"
  subnet_id                  = "${data.terraform_remote_state.shared_networking.myapp01_subnet_id}"
  min_size                   = "${var.vmss_min_size}"
  default_size               = "${var.vmss_default_size}"
  max_size                   = "${var.vmss_max_size}"
  vm_sku_name                = "${var.vm_type}"
  diagnostic_storage_account = "${var.diagnostic_storage_account}"
  upgrade_policy             = "Automatic"
  lb_bepool_IDs              = ["${module.myapp01_dev_load_balancer.backend_address_pool_id}"]
  os_disk_type               = "${var.os_disk_type}"
  tags                       = "${var.tags}"
}

module "myapp01_dev_load_balancer" {
  source                     = "git::ssh://git@yourRepoURL.com/terraform.git?ref=master//load_balancer"

  resource_group             = "${module.myapp01_dev_resource_group.resource_group_name}"
  location                   = "${var.location}"
  app_code                   = "${var.app_code}"
  app_name                   = "${var.app_name}"
  app_environment            = "${var.environment}"
  lb_sku                     = "Standard"
  lb_rules                   = ["${var.lb_rules}"]
  ip_address                 = "${var.lb_ip_address}"
  subnet_id                  = "${local.myapp01_subnet_id}"
  metrics_storage_account    = "${var.metrics_storage_account}"
  metrics_storage_account_rg = "${var.metrics_storage_account_rg}"
  alert_log_retention        = "${var.alert_log_retention}"
  health_log_retention       = "${var.health_log_retention}"
  metrics_log_retention      = "${var.metrics_log_retention}"
}
