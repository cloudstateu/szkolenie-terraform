# --- CUSTOM ROLE --- NetworkWatcher user
resource "azurerm_role_definition" "netops-reader" {
  name        = "netops-reader"
  scope       = data.azurerm_resource_group.tests.id
  description = "netops-reader"

  permissions {
    actions   = [
      "Microsoft.Resources/subscriptions/resourceGroups/read",
      "Microsoft.Portal/dashboards/read",
      "Microsoft.Network/*/read",
      "Microsoft.OperationalInsights/workspaces/search/action", 
      "Microsoft.Network/networkWatchers/ipFlowVerify/action",
      "Microsoft.Network/networkWatchers/nextHop/action",
      "Microsoft.Network/networkWatchers/queryFlowLogStatus/action",
      "Microsoft.Network/networkWatchers/queryTroubleshootResult/action",
      "Microsoft.Network/networkWatchers/queryConnectionMonitors/action",
      "Microsoft.Network/networkWatchers/topology/action",
      "Microsoft.Network/networkWatchers/troubleshoot/action",
      "Microsoft.Network/networkWatchers/connectivityCheck/action",
      "Microsoft.Network/networkWatchers/azureReachabilityReport/action",
      "Microsoft.Network/networkWatchers/availableProvidersList/action",
      "Microsoft.Network/networkWatchers/connectionMonitors/query/action",
      "Microsoft.Network/networkWatchers/lenses/query/action",
      "Microsoft.Network/virtualHubs/effectiveRoutes/action",
      "Microsoft.ResourceHealth/*/read"
      ]
    not_actions = []
  }
}


# --- CUSTOM ROLE --- Virtual Network subnet, NSG, UDR contributor 
resource "azurerm_role_definition" "netops-project-contributor" {
  name = "netops-project-contributor"
  scope       =  data.azurerm_resource_group.tests.id
  description = "netops-project-contributor"

  permissions {
    actions = [
      "Microsoft.Resources/subscriptions/resourceGroups/read",
      "Microsoft.Portal/dashboards/read",
      "Microsoft.OperationalInsights/workspaces/search/action",
      "Microsoft.ResourceHealth/*/read",
      "Microsoft.Network/virtualNetworks/read",
      "Microsoft.Network/virtualNetworks/write",
      "Microsoft.Network/virtualNetworks/join/action",
      "Microsoft.Network/virtualNetworks/subnets/read",
      "Microsoft.Network/virtualNetworks/subnets/join/action",
      "Microsoft.Network/virtualNetworks/subnets/write",
      "Microsoft.Network/virtualNetworks/subnets/delete",
      "Microsoft.Network/networkSecurityGroups/*",
      "Microsoft.Network/routeTables/*"
    ]
    not_actions = []
  }
}