#!/bin/bash
# Referece : https://docs.vmware.com/en/VMware-vSphere-Container-Storage-Plug-in/2.0/vmware-vsphere-csp-getting-started/GUID-8D903051-A401-4BC9-8DB1-91D289B06878.html
export GOVC_INSECURE=1
source vsphere.env

export GOVC_URL="https://${VC_USER}:${VC_PWD}@${VCENTER}"
govc ls ${VC_DATACENTER}/vm ${VC_DATACENTER}/network
govc ls  ${VC_DATACENTER}/host
govc ls  ${VC_DATACENTER}/datastore

#To retrieve all Node VMs

NODES=`govc ls /${VC_DATACENTER}/vm/${OCP_VM_PREFIX}*`


#To enable disk UUID, run the following command for all node VMs that are part of the Kubernetes cluster.
for NODE in ${NODES}
do
echo -e "\n $NODE"
govc vm.change -vm "${NODE}" -e="disk.enableUUID=1"
done

# To upgrade the VM hardware version of node VMs to 15 or higher, run the following command for all node VMs that are part of the Kubernetes cluster.
#govc vm.upgrade -version=15 -vm '/<datacenter-name>/vm/<vm-name1>'
