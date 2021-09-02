# ------- Azure Policy - Not allowed resource types -----------

resource "azurerm_policy_definition" "azpoldef-InvalidResourceTypes" {
  name         = "azpoldef-InvalidResourceTypes"
  display_name = "azpoldef-InvalidResourceTypes"
  policy_type  = "Custom"
  mode         = "Indexed"
  description  = "This policy enables you to specify the resource types that your organization can deploy. Only resource types that support 'tags' and 'location' will be affected by this policy. To restrict all resources please duplicate this policy and change the 'mode' to 'All'."

  metadata = <<METADATA
    {
         "version": "2.0.0",
         "category": "PEKAO"
    }

METADATA


  policy_rule = <<POLICY_RULE
    {
        "if": {
                    "allOf": [
                      {
                          "field": "type",
                          "in": "[parameters('listOfResourceTypesNotAllowed')]"
                      },
                      {
                          "value": "[field('type')]",
                          "exists": true
                      }
                    ]
                },
                "then": {
                    "effect": "[parameters('effect')]"
                }

    }
POLICY_RULE

  parameters = <<PARAMETERS
    {
        "listOfResourceTypesNotAllowed": {
                    "type": "Array",
                    "metadata": {
                      "description": "The list of resource types that cannot be deployed.",
                      "displayName": "Not allowed resource types",
                      "strongType": "resourceTypes"
                    }
                },
                "effect": {
                    "type": "string",
                    "defaultValue": "Audit",
                    "allowedValues": [
                      "Audit",
                      "Deny",
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

# -------- Azure Policy - Allowed locations -----------

resource "azurerm_policy_definition" "azpoldef-AllowedLocations" {
  name         = "azpoldef-AllowedLocations"
  display_name = "azpoldef-AllowedLocations"
  policy_type  = "Custom"
  mode         = "Indexed"
  description  = "This policy enables you to restrict the locations your organization can specify when deploying resources. Use to enforce your geo-compliance requirements. Excludes resource groups, Microsoft.AzureActiveDirectory/b2cDirectories, and resources that use the 'global' region."

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
                "field": "location",
                "notIn": "[parameters('listOfAllowedLocations')]"
            },
            {
                "field": "location",
                "notEquals": "global"
            },
            {
                "field": "type",
                "notEquals": "Microsoft.AzureActiveDirectory/b2cDirectories"
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
        "listOfAllowedLocations": {
            "type": "Array",
            "metadata": {
                "description": "The list of locations that can be specified when deploying resources.",
                "strongType": "location",
                "displayName": "Allowed locations"
            }
        }
    }
PARAMETERS

}