#!/bin/bash
source local.env
oc apply -f oc-scc-adm.yaml

kubectl create namespace ${NAMESPACE}
kubectl config set-context --current --namespace=${NAMESPACE}


oc apply -n ${NAMESPACE} -f yelb-deployment.yaml
oc apply -n ${NAMESPACE} -f yelb-svc-all-cip.yaml
oc apply -n ${NAMESPACE} -f yelb-svc-ui-np.yaml
oc apply -n ${NAMESPACE} -f yelb-svc-ui-lb.yaml
oc apply -n ${NAMESPACE} -f http-ingress-np.yaml
oc apply -n ${NAMESPACE} -f https-ingress-np.yaml

oc apply -n ${NAMESPACE} -f route-ingress.yaml

oc adm policy add-scc-to-user privileged -n ${NAMESPACE} -z deployer
oc adm policy add-scc-to-user privileged -n ${NAMESPACE} -z builder
oc adm policy add-scc-to-user privileged -n ${NAMESPACE} -z default

oc adm policy add-scc-to-user anyuid -n ${NAMESPACE}  -z deployer
oc adm policy add-scc-to-user anyuid -n ${NAMESPACE} -z builder
oc adm policy add-scc-to-user anyuid -n ${NAMESPACE} -z default



watch oc get all -n ${NAMESPACE}

kubectl get ingress  -n ${NAMESPACE}

oc get routes -n ${NAMESPACE}

