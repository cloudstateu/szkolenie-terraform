data "azurerm_subscription" "current"{

}

data "azurerm_resource_group" "tests" {
  name = "tests"
}