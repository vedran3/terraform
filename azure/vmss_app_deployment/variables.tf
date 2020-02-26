## template variables
variable "location" {
  type        = "string"
  description = "Region to deploy service(s) into"
  default     = "eastus2"
}

variable "vm_type" {
  type        = "string"
  description = "the virtual machine type to deploy"
  default     = "Standard_E2s_v3"
}

variable "compliance" {
  type        = "string"
  description = "Level of compliance for system (i.e. PCI, SOX, or Open)"
}

variable "app_name" {
  type        = "string"
  description = "unique identifier for particular appset"
}

variable "app_code" {
  type        = "string"
  description = "unique identifier for particular appset"
}

variable "environment" {
  type        = "string"
  description = "environment name for app"
  default     = ""
}

variable "tags" {
  type        = "map"
  description = "tags"

  default = {
    "app_code"           = "myapp01"
    "compliance"         = "open"
    "cost_center_number" = "12345"
    "environment"        = "dev"
    "source"             = "terraform"
    "power_mgmt"         = "myapp01_dev"
  }
}

variable "diagnostic_storage_account" {
  type        = "string"
  description = "Diagnostic storage account"
  default     = "nonproddiaglogne"
}

variable "image_name" {
  type        = "string"
  description = "The image name of the source managed image"
  default     = ""
}

variable "sudoer_list" {
  type        = "string"
  description = "comma delimited list of sudo groups to allow root"
  default     = ""
}

variable "image_resource_group" {
  type        = "string"
  description = "The path of the source managed disk"

  default = "nonprod_packerbld_ne_0"
}

variable "index" {
  type        = "string"
  description = "comma delimited list of sudo groups to allow root"
}

variable "static_ip_list" {
  type        = "list"
  description = "list of static IPs for app instances if necessary"
  default     = []
}

variable "enable_accelerated_networking" {
  type        = "string"
  description = "comma delimited list of sudo groups to allow root"
  default     = true
}

variable "envcode" {
  type        = "string"
  description = "3 character env code"
}

variable "number_disks" {
  type        = "string"
  description = "The image name of the source managed image"
  default     = "1"
}

variable "os_disk_type" {
  type        = "string"
  description = "OS Storage Type"
  default     = "StandardSSD_LRS"
}

variable "cost_center_number" {
  type        = "string"
  description = "Cost Center for Chargeback"
}

variable "lb_ip_address" {
  type        = "string"
  description = "ip of LB"
  default     = ""
}

variable "lb_rules" {
  type        = "list"
  description = "list of LB port rules in format: <name>|<protocol>|<FE port>|<BE port>"
}

variable "metrics_storage_account" {
  type        = "string"
  description = "storage account"
  default     = "nonproddiaglogne"
}

variable "metrics_storage_account_rg" {
  type        = "string"
  description = "storage account resource group"
  default     = "nonprod_diaglog_ne_0"
}

variable "alert_log_retention" {
  type        = "string"
  description = "Standard Load Balancer Access Log retention (in days: 0-365)"
  default     = "3"
}

variable "health_log_retention" {
  type        = "string"
  description = "Standard Load Balancer Performance Log retention (in days: 0-365)"
  default     = "3"
}

variable "metrics_log_retention" {
  type        = "string"
  description = "Standard Load Balancer Metrics Retention (in days: 0-365)"
  default     = "3"
}

variable "vmss_min_size" {
  type        = "string"
  description = "minimum number of VMSS members"
  default     = "2"
}

variable "vmss_max_size" {
  type        = "string"
  description = "maximum number of VMSS members"
  default     = "2"
}

variable "vmss_default_size" {
  type        = "string"
  description = "default number of VMSS members"
  default     = "2"
}