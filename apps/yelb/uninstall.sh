#!/bin/bash
source local.env


oc delete -n ${NAMESPACE} -f yelb-deployment.yaml
oc delete -n ${NAMESPACE} -f yelb-svc-np.yaml
oc delete -n ${NAMESPACE} -f  http-ingress-np.yaml
oc delete -n ${NAMESPACE} -f  https-ingress-np.yaml
oc delete -n ${NAMESPACE} -f route-ingress.yaml
oc delete -n ${NAMESPACE} -f  yelb-lb.yaml

kubectl config set-context --current --namespace=default


#oc-scc-adm.yaml 
#yelb-ui-cip.yaml
#http-ingress-overlb.yaml   
#https-secret.yaml  
#https-ingress-overnp.yaml  
#yelb-nodeport.yaml
#http-ingress-overnp.yaml   
#yelb-lb.yaml 
#yelb-ui-np.yaml

