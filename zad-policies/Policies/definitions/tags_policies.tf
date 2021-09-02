# -------- Azure Policy - Inherit a tag from the resource group ----------

resource "azurerm_policy_definition" "azpoldef-InheritTag_AddOrReplace" {
  name         = "azpoldef-InheritTag_AddOrReplace"
  display_name = "azpoldef-InheritTag_AddOrReplace"
  policy_type  = "Custom"
  mode         = "Indexed"
  description  = "Adds or replaces the specified tag and value from the parent resource group when any resource is created or updated. Existing resources can be remediated by triggering a remediation task."

  metadata = <<METADATA
    {
        "version":  "1.0.0",
        "category": "PEKAO"
    }

METADATA


  policy_rule = <<POLICY_RULE
    {
        "if": {
          "allOf": [
            {
              "field": "[concat('tags[', parameters('tagName'), ']')]",
              "exists": "false"
            },
            {
              "value": "[resourceGroup().tags[parameters('tagName')]]",
              "notEquals": ""
            }
          ]
        },
        "then": {
          "effect": "audit"
        }
      }
POLICY_RULE


  parameters = <<PARAMETERS
    {
        "tagName": {
          "type": "String",
          "metadata": {
            "displayName": "Tag Name",
            "description": "Name of the tag, such as 'environment'"
          }
        }
    }
PARAMETERS

}

# -------- Azure Policy - Require a tag on resource groups ----------

resource "azurerm_policy_definition" "azpoldef-ResourceGroupRequireTag" {
  name         = "azpoldef-ResourceGroupRequireTag"
  display_name = "azpoldef-ResourceGroupRequireTag"
  policy_type  = "Custom"
  mode         = "All"
  description  = "Enforces existence of a tag on resource groups."

  metadata = <<METADATA
    {
        "version":  "1.0.0",
        "category": "PEKAO"
    }

METADATA


  policy_rule = <<POLICY_RULE
    {
      "if": {
                  "allOf": [
                    {
                        "field": "type",
                        "equals": "Microsoft.Resources/subscriptions/resourceGroups"
                    },
                    {
                        "field": "[concat('tags[', parameters('tagName'), ']')]",
                        "exists": "false"
                    }
                  ]
              },
              "then": {
                  "effect": "audit"
              }
      }
POLICY_RULE


  parameters = <<PARAMETERS
    {
      "tagName": {
                  "type": "String",
                  "metadata": {
                    "displayName": "Tag Name",
                    "description": "Name of the tag, such as 'environment'"
                  }
              }
    }
PARAMETERS

}