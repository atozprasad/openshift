#!/bin/bash
ACME_SECRET=VMware1!
NAMESPACE=acme-fitness

kubectl create ns ${NAMESPACE}
kubectl -n ${NAMESPACE} apply -f 01-create-pvc.yaml
kubectl -n ${NAMESPACE} create secret generic cart-redis-pass --from-literal=password=${ACME_SECRET}
kubectl -n ${NAMESPACE} apply -f cart-redis-total.yaml
kubectl -n ${NAMESPACE} apply -f cart-total.yaml
kubectl -n ${NAMESPACE} create secret generic catalog-mongo-pass --from-literal=password=${ACME_SECRET}
kubectl -n ${NAMESPACE} create -f catalog-db-initdb-configmap.yaml
kubectl -n ${NAMESPACE} apply -f catalog-db-total.yaml
kubectl -n ${NAMESPACE} apply -f catalog-total.yaml
kubectl -n ${NAMESPACE} apply -f payment-total.yaml
kubectl -n ${NAMESPACE} create secret generic order-postgres-pass --from-literal=password=${ACME_SECRET}
kubectl -n ${NAMESPACE} apply -f order-db-total.yaml
kubectl -n ${NAMESPACE} apply -f order-total.yaml
kubectl -n ${NAMESPACE} create secret generic users-mongo-pass --from-literal=password=${ACME_SECRET}
kubectl -n ${NAMESPACE} create secret generic users-redis-pass --from-literal=password=${ACME_SECRET}
kubectl -n ${NAMESPACE} create -f users-db-initdb-configmap.yaml
kubectl -n ${NAMESPACE} apply -f users-db-total.yaml
kubectl -n ${NAMESPACE} apply -f users-redis-total.yaml
kubectl -n ${NAMESPACE} apply -f users-total.yaml
kubectl -n ${NAMESPACE} apply -f frontend-total.yaml
kubectl -n ${NAMESPACE} apply -f point-of-sales-total.yaml
kubectl -n ${NAMESPACE} apply -f point-of-sales-total.yaml

####  LB & Route objects
oc -n ${NAMESPACE} apply -f acme-lb.yaml
oc -n ${NAMESPACE} apply -f route-ingress.yaml
#kubectl -n ${NAMESPACE} apply -f https-secret.yaml
#kubectl -n ${NAMESPACE} apply -f https-ingress-overnp.yaml

## Apply SCC to the serviceaccounts/users default, deployer, builder
echo -e "\n\t Applying  SCC to the serviceaccounts/users default, deployer, builder"


oc adm policy add-scc-to-user anyuid -n ${NAMESPACE}  -z deployer
oc adm policy add-scc-to-user anyuid -n ${NAMESPACE} -z builder
oc adm policy add-scc-to-user anyuid -n ${NAMESPACE} -z default
oc adm policy add-scc-to-user privileged -n ${NAMESPACE} -z deployer
oc adm policy add-scc-to-user privileged -n ${NAMESPACE} -z builder
oc adm policy add-scc-to-user privileged -n ${NAMESPACE} -z default

kubectl config set-context --current --namespace=${NAMESPACE}
