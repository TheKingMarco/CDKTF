# Storage account management policy block definition
resource "azurerm_storage_management_policy" "samp" {
  storage_account_id = var.storage_account_id #required

  rule { # rule block can be instantiated multiple times
    name    = var.rule_name #required
    enabled = var.rule_enabled   #required

    filters {
      prefix_match = var.filters_prefix_match
      blob_types   = var.filters_blob_types #required

      dynamic "match_blob_index_tag" {
        for_each = var.match_blob_index_tag == null ? [] : list(var.match_blob_index_tag)

        content {
          name = match_blob_index_tag.name
          operation = match_blob_index_tag.operation
          value = match_blob_index_tag.value
        }
      }

    }

    actions {

      base_blob {
        tier_to_cool_after_days_since_modification_greater_than    = var.blob_tier_to_cool_after_days_since_modification_greater_than
        tier_to_archive_after_days_since_modification_greater_than = var.blob_tier_to_archive_after_days_since_modification_greater_than
        tier_to_archive_after_days_since_last_access_time_greater_than = var.tier_to_archive_after_days_since_last_access_time_greater_than
        delete_after_days_since_modification_greater_than          = var.blob_delete_after_days_since_modification_greater_than
        delete_after_days_since_last_access_time_greater_than  = var.delete_after_days_since_last_access_time_greater_than
        tier_to_cool_after_days_since_last_access_time_greater_than = var.tier_to_cool_after_days_since_last_access_time_greater_than 
      }

      snapshot {
        change_tier_to_archive_after_days_since_creation = var.snapshot_change_tier_to_archive_after_days_since_creation
        change_tier_to_cool_after_days_since_creation    = var.snapshot_change_tier_to_cool_after_days_since_creation
        delete_after_days_since_creation_greater_than    = var.snapshot_delete_after_days_since_creation_greater_than
      }

      version {
        change_tier_to_archive_after_days_since_creation = var.version_change_tier_to_archive_after_days_since_creation
        change_tier_to_cool_after_days_since_creation    = var.version_change_tier_to_cool_after_days_since_creation
        delete_after_days_since_creation                 = var.version_delete_after_days_since_creation
      }

    }

  }

}