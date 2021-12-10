#!/bin/bash
#helm repo add bitnami https://charts.bitnami.com/bitnami
#helm install kubeapps --namespace kubeapps bitnami/kubeapps

#!/bin/bash
### Installing my sql app

### Enabled one of the two available variables
#CTL=kubectl

CTL=oc
NAMESPACE=kubeapps 



#Step-1 Create NameSpace
kubectl create namespace ${NAMESPACE}

#Step-2 Install Kubeapps
helm install kubeapps kubeapps --namespace ${NAMESPACE}

if [ $CTL = "oc" ]
then
  oc adm policy add-scc-to-user anyuid -n ${NAMESPACE} -z default
  oc adm policy add-scc-to-user anyuid -n ${NAMESPACE} -z builder
  oc adm policy add-scc-to-user anyuid -n ${NAMESPACE} -z deployer
  oc adm policy add-scc-to-user anyuid -n ${NAMESPACE} -z kubeapps-internal-apprepository-controller
  oc adm policy add-scc-to-user anyuid -n ${NAMESPACE} -z kubeapps-internal-kubeops
fi
#Step-3 Creating demo credentials
kubectl create --namespace default serviceaccount kubeapps-operator
kubectl create clusterrolebinding kubeapps-operator --clusterrole=cluster-admin --serviceaccount=default:kubeapps-operator


#Step-4 Retrieve the token
kubectl get --namespace default secret $(kubectl get --namespace default serviceaccount kubeapps-operator -o jsonpath='{range .secrets[*]}{.name}{"\n"}{end}' | grep kubeapps-operator-token) -o jsonpath='{.data.token}' -o go-template='{{.data.token | base64decode}}' && echo

#Step-5 Port forward
kubectl port-forward -n kubeapps svc/kubeapps 8080:80


