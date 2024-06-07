#!/bin/bash

#####################################################
#launch this script to deploy non persistent wordpress
#####################################################

##add repo #
helm repo add bitnami https://charts.bitnami.com/bitnami

#update list of chart
helm repo update

##deploy wordpress
helm install -f wordpress-config.yml mio-wordpress bitnami/wordpress --atomic

##for others helm chart go to https://artifact.io/