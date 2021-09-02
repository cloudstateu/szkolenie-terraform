
# -------- Azure Policy - Authentication should be enabled on your Function app ----------

resource "azurerm_policy_definition" "azpoldef-EnableAuthentication_functionApp" {
  name         = "azpoldef-EnableAuthentication_functionApp"
  display_name = "azpoldef-EnableAuthentication_functionApp"
  policy_type  = "Custom"
  mode         = "Indexed"
  description  = "Azure App Service Authentication is a feature that can prevent anonymous HTTP requests from reaching the Function app, or authenticate those that have tokens before they reach the Function app"

  metadata = <<METADATA
    {
      "version": "1.0.0",
      "category": "PEKAO"
    }
    METADATA

  policy_rule = <<POLICY_RULE
    {
      "if": {
        "allOf": [
          {
            "field": "type",
            "equals": "Microsoft.Web/sites"
          },
          {
            "field": "kind",
            "equals": "functionapp"
          }
        ]
      },
      "then": {
        "effect": "[parameters('effect')]",
        "details": {
          "type": "Microsoft.Web/sites/config",
          "name": "web",
          "existenceCondition": {
            "field": "Microsoft.Web/sites/config/siteAuthEnabled",
            "equals": "true"
          }
        }
      }
    }
    POLICY_RULE

  parameters = <<PARAMETERS
    {
      "effect": {
        "type": "string",
        "defaultValue": "AuditIfNotExists",
        "allowedValues": [
          "Audit",
          "AuditIfNotExists",
          "Disabled"
        ],
        "metadata": {
          "displayName": "Effect",
          "description": "Enable or disable the execution of the policy"
        }
      }
    }
    PARAMETERS
}