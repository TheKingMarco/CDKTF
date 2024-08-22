variable "storage_account_id" {
  description = "Specifies the id of the storage account to apply the management policy to."
  type        = string
}

variable "rule_name" {
  description = "A rule name can contain any combination of alpha numeric characters. Rule name is case-sensitive. It must be unique within a policy."
  type        = string
}

variable "rule_enabled" {
  description = "Boolean to specify whether the rule is enabled."
  type        = bool
}

variable "filters_prefix_match" {
  description = "An array of strings for prefixes to be matched."
  type        = list(string)
  default     = null
}

variable "filters_blob_types" {
  description = "An array of predefined values. Valid options are blockBlob and appendBlob."
  type        = list(string)
  default     = []

  validation {
    condition     =  alltrue([for e in var.filters_blob_types : contains(["blockBlob","appendBlob"],e)])
    error_message = "Valid options for filters_blob_types are blockBlob and appendBlob."
  }
}

variable "match_blob_index_tag" {
  description = "The filter tag block to filter blob objects."
  type        = object({
    name = string
    operation  = string
    value = string
  })
  default     = null
}

variable "blob_tier_to_cool_after_days_since_modification_greater_than" {
  description = "The age in days after last modification to tier blobs to cool storage. Supports blob currently at Hot tier. Must be between 0 and 99999."
  type        = number
  default     = null
}

variable "tier_to_cool_after_days_since_last_access_time_greater_than" {
  description = "The age in days after last modification to tier blobs to cool storage. Supports blob currently at Hot tier. Must be between 0 and 99999."
  type        = number
  default     = 0
}

variable "tier_to_archive_after_days_since_last_access_time_greater_than" {
  description = "The age in days after last modification to tier blobs to cool storage. Supports blob currently at Hot tier. Must be between 0 and 99999."
  type        = number
  default     = 0
}

variable "delete_after_days_since_last_access_time_greater_than" {
  description = "The age in days after last modification to tier blobs to cool storage. Supports blob currently at Hot tier. Must be between 0 and 99999."
  type        = number
  default     = 0
}

variable "blob_tier_to_archive_after_days_since_modification_greater_than" {
  description = "The age in days after last modification to tier blobs to archive storage. Supports blob currently at Hot or Cool tier. Must be between 0 and 99999."
  type        = number
  default     = null

}

variable "blob_delete_after_days_since_modification_greater_than" {
  description = "The age in days after last modification to delete the blob. Must be between 0 and 99999."
  type        = number
  default     = null
}

variable "snapshot_change_tier_to_archive_after_days_since_creation" {
  description = "The age in days after creation to tier blob snapshot to archive storage. Must be between 0 and 99999."
  type        = number
  default     = 90

  validation {
    condition     = var.snapshot_change_tier_to_archive_after_days_since_creation >= 0 && var.snapshot_change_tier_to_archive_after_days_since_creation <= 99999 
    error_message = "The snapshot_change_tier_to_archive_after_days_since_creation value must be between 0 and 99999."
  }
}

variable "snapshot_change_tier_to_cool_after_days_since_creation" {
  description = "The age in days after creation to tier blob snapshot to cool storage. Must be between 0 and 99999."
  type        = number
  default     = 23

  validation {
    condition     = var.snapshot_change_tier_to_cool_after_days_since_creation >= 0 && var.snapshot_change_tier_to_cool_after_days_since_creation <= 99999 
    error_message = "The snapshot_change_tier_to_cool_after_days_since_creation value must be between 0 and 99999."
  }
}

variable "snapshot_delete_after_days_since_creation_greater_than" {
  description = "The age in days after creation to delete the blob snapshot. Must be between 0 and 99999."
  type        = number
  default     = 31

  validation {
    condition     = var.snapshot_delete_after_days_since_creation_greater_than >= 0 && var.snapshot_delete_after_days_since_creation_greater_than <= 99999 
    error_message = "The snapshot_delete_after_days_since_creation_greater_than value must be between 0 and 99999."
  }
}

variable "version_change_tier_to_archive_after_days_since_creation" {
  description = "The age in days after creation to tier blob version to archive storage. Must be between 0 and 99999."
  type        = number
  default     = 9

  validation {
    condition     = var.version_change_tier_to_archive_after_days_since_creation >= 0 && var.version_change_tier_to_archive_after_days_since_creation <= 99999 
    error_message = "The version_change_tier_to_archive_after_days_since_creation value must be between 0 and 99999."
  }
}

variable "version_change_tier_to_cool_after_days_since_creation" {
  description = "The age in days creation create to tier blob version to cool storage. Must be between 0 and 99999."
  type        = number
  default     = 90

  validation {
    condition     = var.version_change_tier_to_cool_after_days_since_creation >= 0 && var.version_change_tier_to_cool_after_days_since_creation <= 99999 
    error_message = "The version_change_tier_to_cool_after_days_since_creation value must be between 0 and 99999."
  }
}

variable "version_delete_after_days_since_creation" {
  description = "The age in days after creation to delete the blob version. Must be between 0 and 99999."
  type        = number
  default     = 3

  validation {
    condition     = var.version_delete_after_days_since_creation >= 0 && var.version_delete_after_days_since_creation <= 99999 
    error_message = "The version_delete_after_days_since_creation value must be between 0 and 99999."
  }
}