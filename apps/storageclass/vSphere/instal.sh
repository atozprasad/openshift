#!/bin/bash
### Installing my sql app

### Enabled one of the two available variables 
#CTL=kubectl
CTL=oc


$CTL apply -f 00-namespace.yaml

if [ $CTL = "oc" ]
then
  oc adm policy add-scc-to-user anyuid -n app-mysql -z defaul
fi

$CTL apply -f 01-storageclass.yaml
$CTL apply -f 02-mysql-sc-pvc.yaml
$CTL apply -f 03-mysql-deployment.yaml
$CTL apply -f 04-mysql-svc-ClusterIP.yaml
#$CTL apply -f 05-mysql-svc-lb.yaml

$CTL  config set-context --current --namespace=app-mysql

watch $CTL get pod,deployment,pv,pvc,sc

