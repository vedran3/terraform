## Azure remote state configuration

provider "azurerm" {}

## set the remote state location
terraform {
  backend "azurerm" {
    resource_group_name  = "myapp01_tfstate_0"
    storage_account_name = "myapp01tfstatede"
    container_name       = "tfstate"
    key                  = "nonprod/myapp01/component1/myapp01-de-0.tfstate"
  }
}
