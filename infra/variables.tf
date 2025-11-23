variable "cloud_id" {
  description = "Yandex Cloud ID"
  type        = string
  sensitive   = true
}

variable "folder_id" {
  description = "Yandex Cloud Folder ID"
  type        = string
  sensitive   = true
}

variable "zone" {
  type        = string
  default     = "ru-central1-a"
  description = "Zone name"
}

variable "subnets" {
  description = "Subnets configuration for zones"
  type = map(object({
    zone = string
    cidr = string
  }))
  default = {
    subnet-a = {
      zone = "ru-central1-a"
      cidr = "10.0.1.0/24"
    }
    subnet-b = {
      zone = "ru-central1-b"
      cidr = "10.0.2.0/24"
    }
    subnet-d = {
      zone = "ru-central1-d"
      cidr = "10.0.3.0/24"
    }
  }
}

variable "cluster_name" {
  description = "Kubernetes cluster name"
  type        = string
  default     = "k8s-cluster"
}

variable "k8s_version" {
  description = "Kubernetes version"
  type        = string
  default     = "1.32"
}

variable "cluster_ipv4_range" {
  description = "CIDR range for pods"
  type        = string
  default     = "10.2.0.0/16"
}

variable "service_ipv4_range" {
  description = "CIDR range for services"
  type        = string
  default     = "10.3.0.0/16"
}

variable "node_count" {
  description = "Number of worker nodes"
  type        = number
  default     = 3
}

variable "use_preemptible_nodes" {
  description = "Use preemptible instances for nodes"
  type        = bool
  default     = true
}

variable "master_zone" {
  description = "Zone for Kubernetes master"
  type        = string
  default     = "ru-central1-a"
}

variable "kms_key_id" {
  description = "KMS key ID for cluster encryption"
  type        = string
  default     = null
}

variable "node_resources" {
  description = "Node resources configuration"
  type = object({
    memory        = number
    cores         = number
    disk_size     = number
    disk_type     = string
    core_fraction = number
  })
  default = {
    memory        = 2
    cores         = 2
    disk_size     = 30
    disk_type     = "network-hdd"
    core_fraction = 20
  }
}

variable "ssh_username" {
  description = "Username for SSH access to nodes"
  type        = string
  
}

variable "ssh_public_key_path" {
  description = "Path to SSH public key file"
  type        = string
  
}

variable "ssh_private_key_path" {
  description = "Path to SSH private key file"
  type        = string
}
