data "azurerm_subscription" "primary" {

}


data "azurerm_resource_group" "tests" {
  name = "tests"
}

data "azurerm_role_definition" "net-ops-reader" {
  name               = "netops-reader"
  scope              = data.azurerm_resource_group.tests.id
}

data "azurerm_role_definition" "net-ops-contributor" {
  name               = "netops-project-contributor"
  scope              = data.azurerm_resource_group.tests.id
}

# data "azuread_user" "user" {
#   user_principal_name = "mateusz.zadrozny@chmurowisko.pl"
# }