cat > ubuntu-networkingon_k8s.yaml << EOFYMAL
apiVersion: apps/v1
kind: Deployment
metadata:
  creationTimestamp: null
  labels:
    app: ubuntu-networking
  name: ubuntu-networking
  namespace: default
spec:
  replicas: 1
  selector:
    matchLabels:
      app: ubuntu-networking
  strategy: {}
  template:
    metadata:
      creationTimestamp: null
      labels:
        app: ubuntu-networking
    spec:
      containers:
      - image: harbor-repo.vmware.com/challagandlp/tools/ubuntu-networking
        name: ubuntu-networking
        command: ["/bin/sleep", "3650d"]
        resources: {}
      securityContext:
        runAsUser: 0
EOFYMAL

kubectl apply  -f ubuntu-networkingon_k8s.yaml
echo -e "\n lets wait for 10 seconds ..."
sleep 10

PODNAME=`kubectl -n default get --no-headers=true pods -o name | awk -F "/" '{print $2}' | grep ubuntu-networking`
kubectl -n default exec -it $PODNAME  -it /bin/bash
