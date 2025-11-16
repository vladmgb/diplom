output "bucket_name" {
  description = "Name of the created S3 bucket"
  value       = yandex_storage_bucket.terraform_state.bucket
}

output "service_account_id" {
  description = "ID of the Terraform service account"
  value       = yandex_iam_service_account.terraform.id
}

output "service_account_name" {
  description = "Name of the Terraform service account"
  value       = yandex_iam_service_account.terraform.name
}

output "kms_key_id" {
  description = "ID of the KMS key"
  value       = yandex_kms_symmetric_key.kms_key.id
}

output "k8s_service_account_id" {
  description = "ID of the Kubernetes service account"
  value       = yandex_iam_service_account.k8s_cluster.id
}

output "k8s_service_account_name" {
  description = "Name of the Kubernetes service account"
  value       = yandex_iam_service_account.k8s_cluster.name
}

output "access_key" {
  description = "Access key for S3 backend"
  value       = yandex_iam_service_account_static_access_key.terraform_sa_key.access_key
  sensitive   = true
}

output "secret_key" {
  description = "Secret key for S3 backend"
  value       = yandex_iam_service_account_static_access_key.terraform_sa_key.secret_key
  sensitive   = true
}

