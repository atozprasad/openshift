#!/bin/bash
source vsphere.env
export KUBECONFIG=/root/openshift/deploy/auth/kubeconfig
#oc login -u cluster_admin -p <yourPassword>
export GOVC_USERNAME="${VC_USER}"
export GOVC_INSECURE=1
export GOVC_PASSWORD="${VC_PWD}"
export GOVC_URL="${VCENTER}"
#export GOVC_DATACENTER="${VC_DATACENTER}"
VM_PREFIX=${OCP_VM_PREFIX}


IFS=$'\n'
for vm in $(govc ls "/${VC_DATACENTER}/vm/*" | grep $VM_PREFIX); do
echo "For iteration"
 MACHINE_INFO=$(govc vm.info -json -dc=${VC_DATACENTER} -vm.ipath="/$vm" -e=true)
 VM_NAME=$(jq -r ' .VirtualMachines[] | .Name' <<< $MACHINE_INFO | awk '{print tolower($0)}')
 # UUIDs come in lowercase, upper case them
 VM_UUID=$( jq -r ' .VirtualMachines[] | .Config.Uuid' <<< $MACHINE_INFO | awk '{print toupper($0)}')
 echo "Patching $VM_NAME with UUID:$VM_UUID"
 oc patch node $VM_NAME -p "{\"spec\":{\"providerID\":\"vsphere://$VM_UUID\"}}"
done
