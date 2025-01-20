resource "digitalocean_kubernetes_cluster" "primary" {
  name    = var.cluster_name
  region  = var.region
  version = var.k8s_version

  node_pool {
    name       = "worker-pool"
    size       = "s-2vcpu-4gb"
    auto_scale = true
    min_nodes  = 1
    max_nodes  = 3
  }
}