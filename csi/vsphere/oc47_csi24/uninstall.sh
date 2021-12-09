#!/bin/bash

#Step-1 Delete CPI
kubectl delete -f vsphere-cloud-controller-manager.yaml

#Step-2 Delete CSI
kubectl delete secret  vsphere-config-secret --namespace=vmware-system-csi
kubectl delete  -f ./vsphere-csi-driver.yaml

#Step-3 Delete Namesapce
oc delete -f  namespace.yaml


#oc delete -f  cpi-global-secret.yaml
#oc delete -f ./cpi-roles.yaml
#oc delete -f cpi-role-bindings.yaml
#oc delete -f  cpi-daemonset.yaml 



