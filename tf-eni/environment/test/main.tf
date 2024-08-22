#---------------------TEST ISSUE 624 (BB STORAGE ACCOUNT)--------------------------#

data "azurerm_resource_group" "rg_main" {
  name = "MARCO-RG"
}
resource "azurerm_storage_account" "sa" {
  name                     = local.NAMING["STOR"]
  resource_group_name      = data.azurerm_resource_group.rg_main.name
  location                 = data.azurerm_resource_group.rg_main.location
  account_tier             = "Standard"
  account_kind             = "StorageV2"
  account_replication_type = "LRS"
  https_traffic_only_enabled       = true
  blob_properties {
    last_access_time_enabled = true #required true per la creazione del rul management policy, quindi su eni utilizzare la condizione che se è prod allora è a true altrimenti a false
  }
}

resource "azurerm_monitor_diagnostic_setting" "diagnosting_settings" {
  count = data.azurerm_resource_group.rg_main.tags.Env == "prod"  ? length(local.services) : 0
  name                       = "${azurerm_storage_account.sa.name}-sentinel-${local.services[count.index]}"
  target_resource_id         = "${azurerm_storage_account.sa.id}/${local.services[count.index]}/default"
  log_analytics_workspace_id = data.azurerm_log_analytics_workspace.logwork.id

  dynamic "enabled_log" {
    for_each = local.logs
    content {
      category = enabled_log.value
    }
  }

  # metric {
  #   category = "Transaction"
  #   enabled  = false
  # }
}

module "azurerm_storage_management_policy" {
  source = "../../../tf-modules/modules/azurerm_storage_management_policy"

  storage_account_id = azurerm_storage_account.sa.id

  rule_name = "test"
  rule_enabled = true
  filters_blob_types = ["blockBlob"]
}
#----------------------------------------------------------------------------------#

# resource "azurerm_resource_group" "rg_main" {
#   name     = local.NAMING["RG"]
#   location = var.LOCATION
#   tags     = local.TAGS["GENERAL"]
# }

# resource "azurerm_virtual_network" "vnet_main" {
#   name                = local.NAMING["VNET"]
#   location            = azurerm_resource_group.rg_main.location
#   resource_group_name = azurerm_resource_group.rg_main.name
#   address_space       = ["192.168.0.0/16"]
#   tags                = local.TAGS["GENERAL"]
# }

# resource "azurerm_subnet" "subnet_main" {
#   name                 = local.NAMING["SUBNET"]
#   resource_group_name  = azurerm_resource_group.rg_main.name
#   virtual_network_name = azurerm_virtual_network.vnet_main.name
#   address_prefixes     = ["192.168.10.0/24"]
# }

# resource "azurerm_public_ip" "pip_vm" {
#   name                = local.NAMING["PIP"]
#   resource_group_name = azurerm_resource_group.rg_main.name
#   location            = azurerm_resource_group.rg_main.location
#   allocation_method   = "Static"

#   tags = local.TAGS["GENERAL"]
# }

# resource "azurerm_network_interface" "nic_vm" {
#   name                = local.NAMING["NIC"]
#   location            = azurerm_resource_group.rg_main.location
#   resource_group_name = azurerm_resource_group.rg_main.name


#   ip_configuration {
#     name                          = "internal"
#     subnet_id                     = azurerm_subnet.subnet_main.id
#     private_ip_address_allocation = "Dynamic"
#     public_ip_address_id          = azurerm_public_ip.pip_vm.id
#   }

#   tags = local.TAGS["GENERAL"]
# }

# resource "azurerm_linux_virtual_machine" "vm_main" {
#   name                = local.NAMING["VM"]
#   resource_group_name = azurerm_resource_group.rg_main.name
#   location            = azurerm_resource_group.rg_main.location
#   size                = "Standard_B2s"
#   admin_username      = "adminuser"
#   admin_password      = "Complicatissima1!"
#   disable_password_authentication = false

#   network_interface_ids = [
#     azurerm_network_interface.nic_vm.id,
#   ]

#   os_disk {
#     caching              = "ReadWrite"
#     storage_account_type = "Standard_LRS"
#   }

#   source_image_reference {
#     publisher = "Canonical"
#     offer     = "0001-com-ubuntu-server-jammy"
#     sku       = "22_04-lts"
#     version   = "latest"
#   }
#   tags = local.TAGS["GENERAL"]
# }




# data "azurerm_client_config" "current" {}

# resource "azurerm_key_vault" "kv_main" {
#   name                        = local.NAMING["KV"]
#   location                    = azurerm_resource_group.rg_main.location
#   resource_group_name         = azurerm_resource_group.rg_main.name
#   enabled_for_disk_encryption = true
#   tenant_id                   = data.azurerm_client_config.current.tenant_id
#   soft_delete_retention_days  = 7
#   purge_protection_enabled    = false

#   sku_name = "standard"

#   access_policy {
#     tenant_id = data.azurerm_client_config.current.tenant_id
#     object_id = data.azurerm_client_config.current.object_id

#     key_permissions = [
#       "Get",
#     ]

#     secret_permissions = [
#       "Get",
#     ]

#     storage_permissions = [
#       "Get",
#     ]
#   }

#   tags = local.TAGS["GENERAL"]
#   # timeouts {
#   #   update = "1s"
#   # }
# }

# resource "azurerm_private_dns_zone" "pzone_kv" {
#   name                = "privatelink.vaultcore.azure.net"
#   resource_group_name = azurerm_resource_group.rg_main.name
# }

# resource "azurerm_private_endpoint" "pe_kv" {
#   name                = local.NAMING["PE"]
#   location            = azurerm_resource_group.rg_main.location
#   resource_group_name = azurerm_resource_group.rg_main.name
#   subnet_id           = azurerm_subnet.subnet_main.id

#   private_dns_zone_group {
#     name                 = "privatednszonegroup"
#     private_dns_zone_ids = [azurerm_private_dns_zone.pzone_kv.id]
#   }

#   private_service_connection {
#     name                           = local.NAMING["PRIVATE-SC"]
#     private_connection_resource_id = azurerm_key_vault.kv_main.id
#     is_manual_connection           = false
#     subresource_names              = ["Vault"]
#   }
#   tags = local.TAGS["GENERAL"]
# }


# resource "azurerm_private_dns_zone_virtual_network_link" "link_dns_kv" {
#   name                  = "link-dns-kv"
#   resource_group_name   = azurerm_resource_group.rg_main.name
#   private_dns_zone_name = azurerm_private_dns_zone.pzone_kv.name
#   virtual_network_id    = azurerm_virtual_network.vnet_main.id
# }


