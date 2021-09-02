resource "azurerm_storage_account" "storageaccchm" {
  name                     = "storageaccountchm"
  resource_group_name      = azurerm_resource_group.rg2.name
  location                 = azurerm_resource_group.rg2.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_monitor_action_group" "monitor_action_group" {
  name                = "chmura-actiongroup"
  resource_group_name = azurerm_resource_group.rg2.name
  short_name          = "chmactiongr"

  email_receiver {
    name                    = "chmuraalert"
    email_address           = "chmuraalert@test.com"
  }

  sms_receiver {
    name         = "smsalertchm"
    country_code = "1"
    phone_number = "1231231234"
  }
}

resource "azurerm_monitor_metric_alert" "metricalert" {
  name                = "example-metricalert"
  resource_group_name = azurerm_resource_group.rg2.name
  scopes              = [azurerm_storage_account.storageaccchm.id]
  description         = "Action will be triggered when Transactions count is greater than 50."

  criteria {
    metric_namespace = "Microsoft.Storage/storageAccounts"
    metric_name      = "Transactions"
    aggregation      = "Total"
    operator         = "GreaterThan"
    threshold        = 50
  }

  action {
    action_group_id = azurerm_monitor_action_group.monitor_action_group.id
  }
}