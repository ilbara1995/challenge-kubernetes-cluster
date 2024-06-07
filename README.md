# Challenge-kubernetes-cluster

Boostrap a kubernetes cluster using vagrant and virtualbox to create vm, ansible to configure vm, terraform create desired cluster k8s (and form a security benchmark with kube-bench) and helm to provision a simple wordpress deployment without persistence.

# Prerequisites

- Windows host machine (for linux you need to change ip address inside "Vagrantfile" )
- Virtualbox installed on your host
- Vagrant installed on your host

## Deploy project

To provision all the project after clonining the repo simply position yourself inside the folder of the Vagrantfile and launch

### Commands

```powershell
vagrant up
```
## Launch security benchmark with kube-bench

Go to the folder "/terraform/kube-bench/" and simply run

### Commands

```terraform
terraform init
```
```terraform
terraform plan
```
```terraform
terraform apply
```
## Deploy simple wordpress with helm chart

To provision wordpress simply run 

```terraform
helm repo add bitnami https://charts.bitnami.com/bitnami
```

```terraform
terraform inithelm repo update
```

```terraform
helm install -f wordpress-config.yml mio-wordpress bitnami/wordpress --atomic
```
