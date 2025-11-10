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

output "kubeconfig" {
  description = "Kubeconfig for cluster access"
  value = <<EOT
apiVersion: v1
clusters:
- cluster:
    certificate-authority-data: ${yandex_kubernetes_cluster.k8s_cluster.master[0].cluster_ca_certificate}
    server: ${yandex_kubernetes_cluster.k8s_cluster.master[0].external_v4_endpoint}
  name: ${yandex_kubernetes_cluster.k8s_cluster.name}
contexts:
- context:
    cluster: ${yandex_kubernetes_cluster.k8s_cluster.name}
    user: yc-${yandex_kubernetes_cluster.k8s_cluster.name}
  name: ${yandex_kubernetes_cluster.k8s_cluster.name}
current-context: ${yandex_kubernetes_cluster.k8s_cluster.name}
kind: Config
users:
- name: yc-${yandex_kubernetes_cluster.k8s_cluster.name}
  user:
    exec:
      apiVersion: client.authentication.k8s.io/v1beta1
      command: yc
      args:
      - k8s
      - cluster
      - create-token
      - --id
      - ${yandex_kubernetes_cluster.k8s_cluster.id}
EOT
  sensitive = true
}