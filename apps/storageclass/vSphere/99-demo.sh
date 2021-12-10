clear
kubectl get pv,pvc,sc
PODNAME=`kubectl get --no-headers=true pods -o name | awk -F "/" '{print $2}'`
kubectl exec -it pod/$PODNAME  -- mysql -u root -ppassword

#kubectl run -it --rm --image=mysql:5.6 --restart=Never mysql-client -- mysql -h mysql -ppassword
#mysql -u root -p

