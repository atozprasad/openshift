#!/bin/bash
ACME_SECRET=VMware1!
ACME_NAMESPACE=acme-fitness

kubectl -n ${ACME_NAMESPACE} delete secret  cart-redis-pass 
kubectl -n ${ACME_NAMESPACE} delete -f cart-redis-total.yaml
kubectl -n ${ACME_NAMESPACE} delete -f cart-total.yaml
kubectl -n ${ACME_NAMESPACE} delete secret  catalog-mongo-pass 
kubectl -n ${ACME_NAMESPACE} delete -f catalog-db-initdb-configmap.yaml
kubectl -n ${ACME_NAMESPACE} delete -f catalog-db-total.yaml
kubectl -n ${ACME_NAMESPACE} delete -f catalog-total.yaml
kubectl -n ${ACME_NAMESPACE} delete -f payment-total.yaml
kubectl -n ${ACME_NAMESPACE} delete secret  order-postgres-pass 
kubectl -n ${ACME_NAMESPACE} delete -f order-db-total.yaml
kubectl -n ${ACME_NAMESPACE} delete -f order-total.yaml
kubectl -n ${ACME_NAMESPACE} delete secret  users-mongo-pass 
kubectl -n ${ACME_NAMESPACE} delete secret  users-redis-pass 
kubectl -n ${ACME_NAMESPACE} delete -f users-db-initdb-configmap.yaml
kubectl -n ${ACME_NAMESPACE} delete -f users-db-total.yaml
kubectl -n ${ACME_NAMESPACE} delete -f users-redis-total.yaml
kubectl -n ${ACME_NAMESPACE} delete -f users-total.yaml
kubectl -n ${ACME_NAMESPACE} delete -f frontend-total.yaml
kubectl -n ${ACME_NAMESPACE} delete -f point-of-sales-total.yaml

kubectl delete ns ${ACME_NAMESPACE}
