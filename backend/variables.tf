variable "cloud_id" {
  type        = string
  description = "Cloud id"
  sensitive   = true
}

variable "folder_id" {
  type        = string
  description = "Folder id"
  sensitive   = true
}

variable "zone" {
  type        = string
  default     = "ru-central1-a"
  description = "Zone name"
}

variable "bucket_name" {
  type        = string
  default     = "terraform-state-081125"
  description = "Name of the Object Storage bucket"
}

variable "kms_default_algorithm" {
  description = "Default encryption algorithm for KMS key"
  type        = string
  default     = "AES_256"
}

variable "kms_rotation_period" {
  description = "Key rotation period in hours"
  type        = string
  default     = "8760h" # 1 год
  }