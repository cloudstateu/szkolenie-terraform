resource "azurerm_storage_account" "storageacc" {
  name                     = "storageachm"
  resource_group_name      = azurerm_resource_group.rg1.name
  location                 = azurerm_resource_group.rg1.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_application_insights" "appins" {
  name                = "appinsightschm"
  resource_group_name = azurerm_resource_group.rg1.name
  location            = azurerm_resource_group.rg1.location
  application_type    = "web"
}

resource "azurerm_app_service_plan" "appservice" {
  name                = "zad1-asp-chm"
  resource_group_name = azurerm_resource_group.rg1.name
  location            = azurerm_resource_group.rg1.location
  kind                = "FunctionApp"

  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_function_app" "functionapp" {
  name                      = "test-function-chm"
  resource_group_name       = azurerm_resource_group.rg1.name
  location                  = azurerm_resource_group.rg1.location
  app_service_plan_id       = azurerm_app_service_plan.appservice.id
  storage_connection_string = azurerm_storage_account.storageacc.primary_connection_string

  app_settings = {
    AppInsights_InstrumentationKey = azurerm_application_insights.appins.instrumentation_key
  }
  
  identity {
    type = "SystemAssigned"   
  }
}