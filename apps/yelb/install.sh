#!/bin/bash
source local.env
oc apply -f oc-scc-adm.yaml

kubectl create namespace ${NAMESPACE}
kubectl config set-context --current --namespace=${NAMESPACE}

oc apply -n ${NAMESPACE} -f yelb-deployment.yaml
oc apply -n ${NAMESPACE} -f yelb-svc-np.yaml
oc apply -n ${NAMESPACE} -f  http-ingress-np.yaml
oc apply -n ${NAMESPACE} -f  https-secret.yaml
oc apply -n ${NAMESPACE} -f  https-ingress-np.yaml
oc apply -n ${NAMESPACE} -f route-ingress.yaml

oc adm policy add-scc-to-user anyuid -n ${NAMESPACE}  -z deployer
oc adm policy add-scc-to-user anyuid -n ${NAMESPACE} -z builder
oc adm policy add-scc-to-user anyuid -n ${NAMESPACE} -z default
oc adm policy add-scc-to-user privileged -n ${NAMESPACE} -z deplyer
oc adm policy add-scc-to-user privileged -n ${NAMESPACE} -z builder
oc adm policy add-scc-to-user privileged -n ${NAMESPACE} -z default

#oc adm policy add-scc-to-group  scc-admin default -n ${NAMESPACE}
#oc adm policy add-scc-to-user privileged default
#oc adm policy add-scc-to-user privileged -z default -n ${NAMESPACE}



watch oc get all -n ${NAMESPACE}

kubectl get ingress  -n ${NAMESPACE}

oc get routes -n ${NAMESPACE}

