
# -------- Azure Policy - Allowed virtual machine size SKUs ----------

resource "azurerm_policy_definition" "azpoldef-VMSkusAllowed" {
  name         = "azpoldef-VMSkusAllowed"
  display_name = "azpoldef-VMSkusAllowed"
  policy_type  = "Custom"
  mode         = "Indexed"
  description  = "This policy enables you to specify a set of virtual machine size SKUs that your organization can deploy."

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
                  "equals": "Microsoft.Compute/virtualMachines"
               },
               {
                  "not": {
                     "field": "Microsoft.Compute/virtualMachines/sku.name",
                     "in": "[parameters('listOfAllowedSKUs')]"
                  }
               }
            ]
         },
         "then": {
            "effect": "Audit"
         }
  }

    POLICY_RULE

  parameters = <<PARAMETERS
  {
         "listOfAllowedSKUs": {
            "type": "Array",
            "metadata": {
               "description": "The list of size SKUs that can be specified for virtual machines.",
               "displayName": "Allowed Size SKUs",
               "strongType": "VMSKUs"
            }
         }
    }
    PARAMETERS
}

