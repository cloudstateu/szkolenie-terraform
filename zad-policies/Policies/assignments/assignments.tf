# -------- Azure Policy - Authentication should be enabled on your Function app ----------

resource "azurerm_policy_assignment" "azpol-EnableAuthentication_functionApp" {
  name                 = "azpol-FunAppEnableAuth"
  policy_definition_id = data.azurerm_policy_definition.azpoldef-EnableAuthentication_functionApp.id
  scope = data.azurerm_resource_group.rg.id

  metadata = <<METADATA
    {
        "category": "PEKAO"
    }
    METADATA

  parameters = <<PARAMETERS
    {
        "effect": {
          "value": "Audit"
        }
    }
    PARAMETERS
}

# -------- Azure Policy - Allowed virtual machine size SKUs ----------

resource "azurerm_policy_assignment" "azpol-VMSkusAllowed" {
  name                 = "azpol-VMSkusAllowed"
  policy_definition_id = data.azurerm_policy_definition.azpoldef-VMSkusAllowed.id
  scope = data.azurerm_resource_group.rg.id
  
  metadata = <<METADATA
    {
        "category": "PEKAO"
    }
    METADATA

  parameters = <<PARAMETERS
    {        
        "listOfAllowedSKUs": {
            "value": [ 
                "Standard_D8s_v3",
                "Standard_D8as_v4",
                "Standard_D4s_v3",
                "Standard_D2s_v3",
                "Standard_D2_v3",
                "Standard_B2s",
                "Standard_B1s",
                "Standard_B1ms",
                "Standard_DS1_v2"
            ]
        } 
    }
    PARAMETERS
}

# ------- Azure Policy - Not allowed resource types -----------

resource "azurerm_policy_assignment" "azpol-InvalidResourceTypes" {
  name                 = "azpol-InvalidTypes"
  policy_definition_id = data.azurerm_policy_definition.azpoldef-InvalidResourceTypes.id
  scope = data.azurerm_resource_group.rg.id

  metadata = <<METADATA
    {
        "category": "PEKAO"
    }
    METADATA

  parameters = <<PARAMETERS
    {
        "listOfResourceTypesNotAllowed": {
            "value": [ 
                "Wandisco.Fusion",
                "U2uconsult.TheIdentityHub",
                "stackify.retrace",
                "Sparkpost.Basic",
                "Sendgrid.Email",
                "Raygun.CrashReporting",
                "RavenHq.Db",
                "Pokitdok.Platform",
                "Paraleap.CloudMonix",
                "Myget.PackageManagement",
                "Mailjet.Email",
                "LiveArena.Broadcast",
                "84codes.CloudAMQP",
                "Conexlink.MyCloudIT",
                "Microsoft.Classic*"
            ]
        },
        "effect": {
            "value": "Audit"
        }
    }
    PARAMETERS
}

# -------- Azure Policy - Allowed locations -----------

resource "azurerm_policy_assignment" "azpol-AllowedLocations" {
  name                 = "azpol-AllowedLocations"
  policy_definition_id = data.azurerm_policy_definition.azpoldef-AllowedLocations.id
  scope = data.azurerm_resource_group.rg.id

  metadata = <<METADATA
    {
        "category": "PEKAO"
    }
    METADATA

  parameters = <<PARAMETERS
    {
        "listOfAllowedLocations": {
            "value": [ "West Europe", "North Europe", "East US", "West US" ]
        }
    }
    PARAMETERS

}

# ------- Azure Policy - Inherit a tag from the resource group -----------

resource "azurerm_policy_assignment" "azpol-InheritTag_AddOrReplace" {
  name                 = "azpol-InheritTag"
  policy_definition_id = data.azurerm_policy_definition.azpoldef-InheritTag_AddOrReplace.id
  scope = data.azurerm_resource_group.rg.id

  metadata = <<METADATA
    {
        "category": "PEKAO"
    }
    METADATA

  parameters = <<PARAMETERS
    {
        "tagName": {
            "value": "PEKAO"
        }
    }
    PARAMETERS
}

# -------- Azure Policy - Require a tag on resource groups - Owner ----------

resource "azurerm_policy_assignment" "azpol-ResourceGroupRequireTag-Owner" {
  name                 = "azpol-RGRequireTag-Owner"
  policy_definition_id = data.azurerm_policy_definition.azpoldef-ResourceGroupRequireTag.id
  scope = data.azurerm_resource_group.rg.id
  
  metadata = <<METADATA
    {
        "category": "PEKAO"
    }
    METADATA

  parameters = <<PARAMETERS
    {
        "tagName": {
            "value": "Owner"
        }
    }
    PARAMETERS
}