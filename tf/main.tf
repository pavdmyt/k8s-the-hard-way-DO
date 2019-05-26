resource "digitalocean_droplet" "master_node" {
  count              = "${var.master_node_count}"
  name               = "k8s-test-dev-master-node-${var.uname}-${count.index + 1}"
  size               = "${var.master_node_size}"
  region             = "${var.region}"
  image              = "${var.image}"
  private_networking = true

  ssh_keys = [
    "${var.ssh_fingerprint}",
  ]

  connection {
    user        = "root"
    type        = "ssh"
    private_key = "${file(var.pvt_key)}"
    timeout     = "2m"
  }
}

resource "digitalocean_droplet" "worker_node" {
  count              = "${var.worker_node_count}"
  name               = "k8s-test-dev-worker-node-${var.uname}-${count.index + 1}"
  size               = "${var.worker_node_size}"
  region             = "${var.region}"
  image              = "${var.image}"
  private_networking = true

  ssh_keys = [
    "${var.ssh_fingerprint}",
  ]

  connection {
    user        = "root"
    type        = "ssh"
    private_key = "${file(var.pvt_key)}"
    timeout     = "2m"
  }
}

resource "digitalocean_loadbalancer" "k8s_lb" {
  name        = "k8s-test-lb"
  region      = "${var.region}"
  droplet_ids = ["${digitalocean_droplet.master_node.*.id}"]

  forwarding_rule {
    entry_port     = 6443
    entry_protocol = "tcp"

    target_port     = 6443
    target_protocol = "tcp"
  }

  forwarding_rule {
    entry_port     = 22
    entry_protocol = "tcp"

    target_port     = 22
    target_protocol = "tcp"
  }

  healthcheck {
    port     = 22
    protocol = "tcp"
  }
}
