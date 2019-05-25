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
