#!/bin/bash
### Installing my sql app

### Enabled one of the two available variables 
#CTL=kubectl
CTL=oc


$CTL delete -f 05-mysql-svc-lb.yaml
$CTL delete -f 04-mysql-svc-ClusterIP.yaml
$CTL delete -f 03-mysql-deployment.yaml
$CTL delete -f 02-mysql-sc-pvc.yaml
$CTL delete -f 01-storageclass.yaml
$CTL delete -f 00-namespace.yaml
