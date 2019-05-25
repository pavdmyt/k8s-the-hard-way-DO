output "masters_ipv4" {
  value = ["${digitalocean_droplet.master_node.*.ipv4_address}"]
}

output "worker_nodes_ipv4" {
  value = ["${digitalocean_droplet.worker_node.*.ipv4_address}"]
}
