terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
      }
  }
  required_version = ">=1.5"

  backend "s3" {
    endpoints = {
      s3 = "https://storage.yandexcloud.net"
    }
    bucket     = "terraform-state-081125" 
    key        = "k8s-cluster/terraform.tfstate"
    region     = "ru-central1"

    skip_region_validation      = true
    skip_credentials_validation = true
    skip_requesting_account_id  = true
    skip_s3_checksum            = true

  }

}

provider "yandex" {
  cloud_id                 = var.cloud_id
  folder_id                = var.folder_id
  zone                     = var.zone
  service_account_key_file = file("~/.ssh/key.json")
  
}



