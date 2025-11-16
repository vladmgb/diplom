# Создание VPC сети
resource "yandex_vpc_network" "k8s_network" {
  name        = "k8s-network"
  description = "VPC network for Kubernetes cluster"
}

# Создание 3 подсетей в разных зонах доступности
resource "yandex_vpc_subnet" "k8s_subnets" {
  for_each = var.subnets

  name           = "k8s-subnet-${each.key}"
  zone           = each.value.zone
  network_id     = yandex_vpc_network.k8s_network.id
  v4_cidr_blocks = [each.value.cidr]

  depends_on = [yandex_vpc_network.k8s_network]
}

# Создан в бекенде
data "yandex_iam_service_account" "k8s_cluster" {
  name = "k8s-cluster-sa"  
}

# Базовый кластер k8s
resource "yandex_kubernetes_cluster" "k8s_cluster" {
  name        = var.cluster_name
  description = "Basic Kubernetes cluster with single master"
  network_id  = yandex_vpc_network.k8s_network.id
  cluster_ipv4_range = var.cluster_ipv4_range
  service_ipv4_range = var.service_ipv4_range
  
  master {
    version   = var.k8s_version
    public_ip = true  # Внешний IP для доступа к API

    zonal {
      zone      = var.master_zone
      subnet_id = yandex_vpc_subnet.k8s_subnets["subnet-a"].id
    }

    maintenance_policy {
      auto_upgrade = true

      maintenance_window {
        start_time = "03:00"
        duration   = "3h"
      }
    }
  }

  service_account_id      = data.yandex_iam_service_account.k8s_cluster.id
  node_service_account_id = data.yandex_iam_service_account.k8s_cluster.id

  release_channel = "REGULAR"
  network_policy_provider = "CALICO"

  kms_provider {
    key_id = var.kms_key_id
  }

}

# Группа нод
resource "yandex_kubernetes_node_group" "k8s_nodes" {
  cluster_id = yandex_kubernetes_cluster.k8s_cluster.id
  name       = "k8s-nodes"
  version    = var.k8s_version

  instance_template {
    platform_id = "standard-v2"
    
    resources {
      memory = var.node_resources.memory
      cores  = var.node_resources.cores
      core_fraction = var.node_resources.core_fraction
    }

    boot_disk {
      type = var.node_resources.disk_type
      size = var.node_resources.disk_size
    }

    network_interface {
      nat        = true
      subnet_ids = [for subnet in yandex_vpc_subnet.k8s_subnets : subnet.id]
    }

    scheduling_policy {
      preemptible = var.use_preemptible_nodes
    }

    container_runtime {
      type = "containerd"
    }

    metadata = {
      ssh-keys = "${var.ssh_username}:${file(var.ssh_public_key_path)}"
    }
  }

  scale_policy {
    fixed_scale {
      size = var.node_count
    }
  }

 
  allocation_policy {
    location {
      zone = "ru-central1-a"
    }
    location {
      zone = "ru-central1-b"
    }
    location {
      zone = "ru-central1-d"
    }
  }

  maintenance_policy {
    auto_upgrade = true
    auto_repair  = true

    maintenance_window {
      day        = "monday"
      start_time = "23:00"
      duration   = "3h"
    }
  }
}

