#!/bin/bash
NAMESPACE=acme-fitness

oc -n ${NAMESPACE} delete secret  cart-redis-pass 
oc -n ${NAMESPACE} delete -f cart-redis-total.yaml
oc -n ${NAMESPACE} delete -f cart-total.yaml
oc -n ${NAMESPACE} delete secret  catalog-mongo-pass 
oc -n ${NAMESPACE} delete -f catalog-db-initdb-configmap.yaml
oc -n ${NAMESPACE} delete -f catalog-db-total.yaml
oc -n ${NAMESPACE} delete -f catalog-total.yaml
oc -n ${NAMESPACE} delete -f payment-total.yaml
oc -n ${NAMESPACE} delete secret  order-postgres-pass 
oc -n ${NAMESPACE} delete -f order-db-total.yaml
oc -n ${NAMESPACE} delete -f order-total.yaml
oc -n ${NAMESPACE} delete secret  users-mongo-pass 
oc -n ${NAMESPACE} delete secret  users-redis-pass 
oc -n ${NAMESPACE} delete -f users-db-initdb-configmap.yaml
oc -n ${NAMESPACE} delete -f users-db-total.yaml
oc -n ${NAMESPACE} delete -f users-redis-total.yaml
oc -n ${NAMESPACE} delete -f users-total.yaml
oc -n ${NAMESPACE} delete -f frontend-total.yaml
oc -n ${NAMESPACE} delete -f point-of-sales-total.yaml


####  LB & Route objects
oc -n ${NAMESPACE} delete -f acme-lb.yaml
oc -n ${NAMESPACE} delete -f route-ingress.yaml
#oc -n ${NAMESPACE} apply -f https-secret.yaml
#oc -n ${NAMESPACE} apply -f https-ingress-overnp.yaml

oc delete ns ${NAMESPACE}
