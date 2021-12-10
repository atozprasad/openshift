#!/bin/bash
helm uninstall kubeapps --namespace kubeapps bitnami/kubeapps
#Creating demo credentials
kubectl delete --namespace default serviceaccount kubeapps-operator
kubectl delete clusterrolebinding kubeapps-operator


kubectl delete namespace kubeapps
