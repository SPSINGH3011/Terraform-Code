
terraform {                
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.32.0"
    }
  }
backend "azurerm" {
    resource_group_name = "sp-rg"
    storage_account_name = "sptodorageaccountname"                              
    container_name       = "sptodocontainer"                              
    key                  = "babba.tfstate"                
  }
}


  


provider "azurerm" {
  features{}
  subscription_id = "4c09d51a-2dd9-421f-bff0-ca616d92ca42"
}

            # Label1             Label2   level
resource "azurerm_resource_group" "rg" {
name ="sp-rg"
location = "west us"
}


 resource "azurerm_storage_account" "sa" {
  name                     = "sptodorageaccountname"
  resource_group_name      = "sp-rg"
  location                 = "west us"
  account_tier             = "Standard"
  account_replication_type = "GRS"
    
}

#RG2
resource "azurerm_resource_group" "rg2" {
name ="sp-rg2"
location = "west us"
}

#RG3
resource "azurerm_resource_group" "rg3" {
name ="sp-rg3"
location = "west us"
}


#SA2 IMPLICIT
 resource "azurerm_storage_account" "sa2" {
  name                     = "sptodorageaccountname2"
  resource_group_name      = azurerm_resource_group.rg3.name    # <---"azurerm_resource_group" "rg3"
  location                 = azurerm_resource_group.rg3.location
  account_tier             = "Standard"
  account_replication_type = "GRS"
    
}

#SA3 EXPLICIT
 resource "azurerm_storage_account" "sa3" {
 depends_on = [azurerm_resource_group.rg3  ]
  name                     = "sptodorageaccountname3"
  resource_group_name      = "sp-rg3"
  location                 = "west us"
  account_tier             = "Standard"
  account_replication_type = "GRS"
    
}


#RG4
resource "azurerm_resource_group" "rg4" {
name ="sp-rg4"
location = "west us"
}

#RG5
resource "azurerm_resource_group" "rg5" {
name ="sp-rg5"
location = "west us"
}

#IMPORT BLOCK
import {
  to = azurerm_resource_group.rg5
  id = "/subscriptions/4c09d51a-2dd9-421f-bff0-ca616d92ca42/resourceGroups/sp-rg5"
}

#RG6
resource "azurerm_resource_group" "rg6" {
name ="sp-rg6"
location = "west us"
}


