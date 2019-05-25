variable "do_token" {}
variable "pub_key" {}
variable "pvt_key" {}
variable "ssh_fingerprint" {}
variable "uname" {}

variable "master_node_size" {
  default = "s-2vcpu-4gb"
}

variable "worker_node_size" {
  default = "s-2vcpu-4gb"
}

variable "master_node_count" {
  default     = 3
  description = "Number master nodes in the cluster"
}

variable "worker_node_count" {
  default     = 3
  description = "Number of worker nodes in the cluster"
}

variable "region" {
  default = "fra1"
}

variable "image" {
  default = "ubuntu-18-04-x64"
}
