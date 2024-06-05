provider "kubernetes" {
  config_path = "/home/vagrant/.kube/kube_config_cluster.yml"
}

#test github action terraform lint
resource "null_resource" "delay" {
  provisioner "local-exec" {
    command = "sleep 30"
  }
}


resource "kubernetes_job" "kube_bench" {
  depends_on = [null_resource.delay]

  metadata {
    name = "kube-bench"
  }

  spec {
    template {
      metadata {
        name = "kube-bench"
      }

      spec {
        container {
          image = "aquasec/kube-bench:latest"
          name  = "kube-bench"

          args = [
            "run"
          ]
        }
        restart_policy = "Never"
      }
    }

    backoff_limit = 4
  }
}
