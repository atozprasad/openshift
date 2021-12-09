# CSI Driver manifest files form Openshift website

## Pre-Requisites 
- govc utility : We will use govc utility access vsphere and set the providerID for all the nodes ( if it isnot present already)
- Two config files : Preare two conf file, one for CPI and second for CSI
- CPI ( Cloud Provider Interface) manifest files
- vSphere CSI driver ( CloudnativeStorageInterface driver) manifest files

**Note**: 
- CPI Manifest and dependencies will be deployed in ***kube-system*** namespaces
- (vSphere CSI version <= 2.2.1) vSphere Driver interfaces will be deployed in ***kube-system*** namespaces
- (vSphere CSI version >= 2.3)  vSphere Driver interfaces will be deployed in ***vmware-system-csi*** namespaces

## Procedure
- Prepare Nodes
    - Update the ProviderID on all nodes
    - Taint master nodes to no-schedule
- Installing CPI 
    -  Create a secret object for CPI & deploy it in the kube-system namespace
    - Deploy CPI Manifest file in kube-system namespace. This manifest file inclues ClusterRoles, Roelbinding, Deployment, Daemonset obejcts
- Installing CSI
    - Create a secret Object ***csi-vsphere.conf*** secret & configmap in ***kube-system*** (for v<=2.2.1) or ***vmware-system-csi*** (from v>=2.3)
 - Deploy vsphere-cso-driver.yaml Manifest file  in ***kube-system*** (for v<=2.2.1) or  ***vmware-system-csi*** (from v>=2.3)

- Add newly created serviceaccounts to openshift scc ( security context controls) roles. ( cpi & csi service accounts part of the manifest ) 
ex: oc adm policy add-scc-to-user privileged -z <serviceAccountanem> -n <namespace>
- Validate 
    - Node taints
    - Node Provider ID
    - the pods health in kube-system and vmware-system-csi name space

_________
## Instalaltion 

### Step-0 Update nodes & Prepare config files
You need to Tag your nodes with the providerID and taint your nodes with master-node no-schedule.

#### **0.1 Taint nodes**
`./prepreNodes.sh`

#### **0.2 Tag nodes with ProviderID**

`./setProviderID.sh`

#### **0.3 Prepare vSphere roles**

Follow the document here  : https://docs.vmware.com/en/VMware-vSphere-Container-Storage-Plug-in/2.0/vmware-vsphere-csp-getting-started/GUID-043ACF65-9E0B-475C-A507-BBBE2579AA58.html

***or*** you can use the govc script provided here. 
./createVSRoles.sh


### Step-1 Prepare Conffiles
You have vsphere.env.sample file in this repo. Copy that file to vsphere.env and update with approprivate values. 

#### **1.1 Prepare vsphere.env file**
`cp vsphere.env.sample vspehre.env`
`vi vsphere.env`
#### **1.2 generat config files for CPI & CSI e**
`./generate_conf.sh`

`ls -lrt vsphere.conf csi-vsphere.conf`

### Step-2 Cloud Provider interface @ kube-system namespace

#### **2.1 Create  configmap & secret**
`oc create configmap cloud-config --from-file=./vsphere.conf --namespace=kube-system`
`oc create -f  cpi-global-secret.yaml`

#### **2.2 Deploy CPI role, rolebinding,deployement & demanonset @ kube-system namespace**

oc create -f ./cpi-roles.yaml
oc create -f cpi-role-bindings.yaml

###Step-3 vSphere CSI @ Kube-system or @vmware-system-csi namespace 

#### **3.1 Create  configmap & secret**

`oc create secret generic vsphere-config-secret --from-file=./csi-vsphere.conf --namespace=kube-system`

***or***

`oc create secret generic vsphere-config-secret --from-file=./csi-vsphere.conf --namespace=vmware-system-csi`

#### **3.2 Deploy vSphere CSI  role, rolebinding,deployement & demanonset @ kube-system namespace**

`oc create -f ./vsphere-csi-driver.yaml`

### Step-4 Create Global secret in kube-system namespace

#### **4.1 Grant scc privillages to t`he service account cloud-controller-manager**

`oc adm policy add-scc-to-user privileged -z cloud-controller-manager -n kube-syste `

`oc adm policy add-scc-to-user privileged -z vsphere-csi-controller -n kube-system ` 

`oc adm policy add-scc-to-user privileged -z vsphere-csi-controller -n vmware-system-csi`


#### Additional References
- https://docs.vmware.com/en/VMware-vSphere-Container-Storage-Plug-in/2.0/vmware-vsphere-csp-getting-started/GUID-0AB6E692-AA47-4B6A-8CEA-38B754E16567.html
- CPI Plugin installation  https://docs.vmware.com/en/VMware-vSphere-Container-Storage-Plug-in/2.0/vmware-vsphere-csp-getting-started/GUID-0C202FC5-F973-4D24-B383-DDA27DA49BFA.html
- 
- Configuring CoreDNS for vSphere FileSystem  https://docs.vmware.com/en/VMware-vSphere-Container-Storage-Plug-in/2.0/vmware-vsphere-csp-getting-started/GUID-0D0DB21C-E22E-4D26-AFC7-807F42D45161.html
Open shift documentation  ht0tps://github.com/openshift/vmware-vsphere-csi-driver/blob/master/docs/book/releases/v2.3.0.
md 
- Public blog for https://veducate.co.uk/vsphere-csi-driver-openshift-vsan-file-services/
- https://docs.vmware.com/en/VMware-vSphere-Container-Storage-Plug-in/2.0/vmware-vsphere-csp-getting-started/
GUID-54BB79D2-B13F-4673-8CC2-63A772D17B3C.html
- Sample example https://developer.vmware.com/samples/7399/
container-storage-interface-driver-for-vsphere-6-x-7-x-and-openshift-container-platform-4-x#
