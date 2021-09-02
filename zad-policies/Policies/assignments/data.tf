data "azurerm_policy_definition" "azpoldef-EnableAuthentication_functionApp" {
  display_name = "azpoldef-EnableAuthentication_functionApp"
}

data "azurerm_policy_definition" "azpoldef-VMSkusAllowed" {
  display_name = "azpoldef-VMSkusAllowed"
}

data "azurerm_policy_definition" "azpoldef-InvalidResourceTypes" {
  display_name = "azpoldef-InvalidResourceTypes"
}

data "azurerm_policy_definition" "azpoldef-AllowedLocations" {
  display_name = "azpoldef-AllowedLocations"
}

data "azurerm_policy_definition" "azpoldef-InheritTag_AddOrReplace" {
  display_name = "azpoldef-InheritTag_AddOrReplace"
}

data "azurerm_policy_definition" "azpoldef-ResourceGroupRequireTag" {
  display_name = "azpoldef-ResourceGroupRequireTag"
}

data "azurerm_resource_group" "rg" {
  name = "policies-test"
}