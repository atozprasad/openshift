#!/bin/bash


echo -e "\n Generating 2 files (1) csi-vsphere.conf (2) vsphere.conf"
./generateConf.sh
ls -lrt csi-vsphere.conf vsphere.conf

#Step-1 Preparenodes
./prepareNodes.sh

#Step-2 Configuring nodes to enable for CSI driver
./configNodes.sh

#Setep-3 Deploy CPI Driver
##Apply overall yaml for configmap, secret, role, rolebindings, and cpi driver.
kubectl apply -f vsphere-cloud-controller-manager.yaml

#Step-3 validate CPI Driver installation
kubectl describe nodes | grep "ProviderID"


#######################################################################################
#Deploy CSI 2.4
#######################################################################################

# Step1 Create Namepsce vsphere-sytem-csi
kubectl apply -f namespace.yaml

##Step-5.1 Create secret for CSI Driver
kubectl create secret generic vsphere-config-secret --from-file=./csi-vsphere.conf --namespace=vmware-system-csi
##Step-5.2 Create CSI Driver Role, Rolebinding, Deployment
kubectl apply -f ./vsphere-csi-driver.yaml


kubectl describe CSINode/ocp-dev-worker1
#Step-4.1 Grant scc privillages to the service account cloud-controller-manager
oc adm policy add-scc-to-user anyuid -n vmware-system-csi -z defaul
oc adm policy add-scc-to-user privileged -z cloud-controller-manager -n vmware-system-csi
oc adm policy add-scc-to-user privileged -z vsphere-csi-controller -n vmware-system-csi
oc adm policy add-scc-to-user privileged -z vsphere-csi-node -n vmware-system-csi

echo -e "\nsleeping 15 sec..."
sleep 15 

kubectl get csinode -o="custom-columns=NAME:metadata.name,DRIVERS:spec.drivers[].name"
kubectl get CSINode
