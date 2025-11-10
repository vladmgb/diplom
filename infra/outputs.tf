output "cluster_id" {
  description = "Kubernetes cluster ID"
  value       = yandex_kubernetes_cluster.k8s_cluster.id
}

output "cluster_name" {
  description = "Kubernetes cluster name"
  value       = yandex_kubernetes_cluster.k8s_cluster.name
}

output "cluster_external_endpoint" {
  description = "Kubernetes cluster external endpoint"
  value       = yandex_kubernetes_cluster.k8s_cluster.master[0].external_v4_endpoint
}

output "cluster_version" {
  description = "Kubernetes version"
  value       = yandex_kubernetes_cluster.k8s_cluster.master[0].version
}

output "node_group_id" {
  description = "Node group ID"
  value       = yandex_kubernetes_node_group.k8s_nodes.id
}
