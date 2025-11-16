# Создание сервисного аккаунта для Terraform
resource "yandex_iam_service_account" "terraform" {
  name        = "terraform-sa"
  description = "Service account for Terraform"
  folder_id   = var.folder_id
}

# Назначение ролей сервисному аккаунту
resource "yandex_resourcemanager_folder_iam_member" "terraform_roles" {
  for_each = toset(["editor", "vpc.admin", "k8s.admin", "storage.admin"])

  folder_id = var.folder_id
  role      = each.key
  member    = "serviceAccount:${yandex_iam_service_account.terraform.id}"
}

# KMS ключ для шифрования
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

# Создание статического ключа доступа для S3
resource "yandex_iam_service_account_static_access_key" "terraform_sa_key" {
  service_account_id = yandex_iam_service_account.terraform.id
  description        = "Static access key for Terraform S3 backend"
}

# Создание S3 бакета для Terraform state
resource "yandex_storage_bucket" "terraform_state" {
  bucket     = var.bucket_name
  #force_destroy = true
 
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

  depends_on = [
    yandex_iam_service_account_static_access_key.terraform_sa_key
  ]

  provisioner "local-exec" {
  when    = destroy
  interpreter = ["bash", "-c"]
  command = <<EOT
# Удаляем все версии
versions=$(aws s3api list-object-versions \
  --bucket ${self.bucket} \
  --endpoint-url=https://storage.yandexcloud.net \
  --output json)

echo "$versions" | jq -r '.Versions[]?, .DeleteMarkers[]? | [.Key, .VersionId] | @tsv' | \
while IFS=$'\t' read -r key version; do
  aws s3api delete-object \
    --bucket ${self.bucket} \
    --key "$key" \
    --version-id "$version" \
    --endpoint-url=https://storage.yandexcloud.net
done

# Удаляем сам бакет
aws s3 rb s3://${self.bucket} --force --endpoint-url=https://storage.yandexcloud.net
EOT
 }

}


# Создание сервисного аккаунта для Kubernetes кластера
resource "yandex_iam_service_account" "k8s_cluster" {
  name        = "k8s-cluster-sa"
  description = "Service account for Kubernetes cluster"
  folder_id   = var.folder_id
}

# Роли для сервисного аккаунта кластера
resource "yandex_resourcemanager_folder_iam_member" "k8s_cluster_roles" {
  for_each = toset([
    "k8s.clusters.agent",
    "vpc.publicAdmin", 
    "load-balancer.admin",
    "compute.viewer"
  ])

  folder_id = var.folder_id
  role      = each.key
  member    = "serviceAccount:${yandex_iam_service_account.k8s_cluster.id}"
}
