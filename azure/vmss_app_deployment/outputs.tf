## outputs.tf
output "resource_group_name" {
  value = "${module.myapp01_dev_resource_group.resource_group_name}"
}
