# Создание сервисного аккаунта для Terraform

resource "yandex_iam_service_account" "terraform" {
  name        = "terraform-sa"
  description = "Service account for Terraform"
  folder_id   = var.folder_id
}

# Назначение ролей сервисному аккаунту

resource "yandex_resourcemanager_folder_iam_member" "editor" {
  folder_id = var.folder_id
  role      = "editor"
  member    = "serviceAccount:${yandex_iam_service_account.terraform.id}"
}

resource "yandex_resourcemanager_folder_iam_member" "vpc_admin" {
  folder_id = var.folder_id
  role      = "vpc.admin"
  member    = "serviceAccount:${yandex_iam_service_account.terraform.id}"
}

resource "yandex_resourcemanager_folder_iam_member" "k8s_admin" {
  folder_id = var.folder_id
  role      = "k8s.admin"
  member    = "serviceAccount:${yandex_iam_service_account.terraform.id}"
}

resource "yandex_resourcemanager_folder_iam_member" "storage_admin" {
  folder_id = var.folder_id
  role      = "storage.admin"
  member    = "serviceAccount:${yandex_iam_service_account.terraform.id}"
}

# Создание статического ключа доступа для S3
resource "yandex_iam_service_account_static_access_key" "terraform_sa_key" {
  service_account_id = yandex_iam_service_account.terraform.id
  description        = "Static access key for Terraform S3 backend"
}

#### KMS Key

resource "yandex_kms_symmetric_key" "kms_key" {
  name              = "kms-symmetric-key"
  description       = "KMS symmetric key"
  default_algorithm = var.kms_default_algorithm
  rotation_period   = var.kms_rotation_period
}

resource "yandex_kms_symmetric_key_iam_binding" "encrypter" {
  symmetric_key_id = yandex_kms_symmetric_key.kms_key.id
  role             = "kms.keys.encrypterDecrypter"
  
  members = [
    "serviceAccount:${yandex_iam_service_account.terraform.id}",
  ]
}

# Создание S3 бакета для Terraform state

resource "yandex_storage_bucket" "terraform_state" {
  bucket     = var.bucket_name
  force_destroy = true
 
  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = yandex_kms_symmetric_key.kms_key.id
        sse_algorithm     = "aws:kms"
      }
    }
  }

}

