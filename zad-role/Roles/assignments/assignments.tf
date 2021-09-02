resource "azurerm_role_assignment" "user-net-ops-reader-assignment" {
  scope              = data.azurerm_resource_group.tests.id
  role_definition_id = data.azurerm_role_definition.net-ops-reader.id
  principal_id       = "860176dd-e8a1-42d6-8f52-828ed01ebc00"
}

resource "azurerm_role_assignment" "user-net-ops-contributor-assignment" {
  scope              = data.azurerm_resource_group.tests.id
  role_definition_id = data.azurerm_role_definition.net-ops-contributor.id
  principal_id       = "860176dd-e8a1-42d6-8f52-828ed01ebc00"
}

resource "azurerm_role_assignment" "user-reader" {
  scope              = data.azurerm_resource_group.tests.id
  role_definition_name = "Reader"
  principal_id       = "860176dd-e8a1-42d6-8f52-828ed01ebc00"
}