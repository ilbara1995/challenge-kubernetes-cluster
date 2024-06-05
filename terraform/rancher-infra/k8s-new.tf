terraform {
  required_providers {
    rke = {
      source  = "rancher/rke"
      version = "1.5.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.30.0"
    }
  }

}


resource "rke_cluster" "cluster" {

  enable_cri_dockerd = true
  #default kubernetes_version v1.23.4-rancher1-1

  nodes {
    address = "172.17.177.23"
    user    = "vagrant"
    role    = ["controlplane", "etcd", "worker"]
    ssh_key = file("/home/vagrant/.ssh/id_rsa")
  }

  nodes {
    address = "172.17.177.21"
    user    = "vagrant"
    #role    = ["controlplane", "etcd","worker"]
    role    = ["worker"]
    ssh_key = file("/home/vagrant/.ssh/id_rsa")
  }

}

resource "local_file" "kube_cluster_yaml" {
  filename = "/home/vagrant/.kube/kube_config_cluster.yml"
  content  = rke_cluster.cluster.kube_config_yaml
}

provider "kubernetes" {

  host     = rke_cluster.cluster.api_server_url
  username = rke_cluster.cluster.kube_admin_user

  client_certificate     = rke_cluster.cluster.client_cert
  client_key             = rke_cluster.cluster.client_key
  cluster_ca_certificate = rke_cluster.cluster.ca_crt
}

resource "kubernetes_namespace" "example" {
  metadata {
    name = "kiratech-test"
  }
}