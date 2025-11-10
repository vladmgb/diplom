cluster_name = "k8s-cluster"

node_resources = {
  memory        = 2
  cores         = 2
  disk_size     = 30
  disk_type     = "network-hdd"
  core_fraction = 20
}

use_preemptible_nodes = true

node_count = 3

