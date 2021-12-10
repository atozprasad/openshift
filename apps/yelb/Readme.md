# Yelb Demo app for K8S 

[Yelb](http://it20.info.s3-website-us-east-1.amazonaws.com/2017/07/yelb-yet-another-sample-app/) is VMware demo application that was built by Massimo Re Ferre' and Andrea Siviero. This web application contains the following services: UI Frontend, Application Server, Database Server and Caching Service using Redis.

Kubernetes apps can be exposed to outside world using multiple ways. In this example3 we will use two different methods to expose the service.
- **NodePort** based example : [yelb-nodeport.yaml](https://github.com/atozprasad/cna/blob/master/k8s/k8s-examples/multi-tier-apps/yelb/yelb-nodeport.yaml)
- **Load Balancer** example :[yelb-lb.yaml](https://github.com/atozprasad/cna/blob/master/k8s/k8s-examples/multi-tier-apps/yelb/yelb-lb.yaml)
## Example with Node port
### Step 1 - Deploy the application**

`kubectl create ns yelb`

`kubectl apply -f https://github.com/atozprasad/cna/blob/master/k8s/k8s-examples/multi-tier-apps/yelb/yelb-nodeport.yaml`

### Step 2 Exaplore the resources been deployed**

`kubectl -n yelb get pods,deployment,svc`
Note: You should see the pods in the satus *Ready*

### Step 3 Fech access details**

`kubectl -n yelb describe pod $(kubectl -n yelb get pods | grep yelb-ui | awk '{print $1}') | grep "Node:"`

### Step 4 Access app-service from your browser**
http://< IP from prevoius command>:30001

## Example with LoadBalancer

***Pre-requisite:*** Loadbalancer service should be available at the Perimeter level and should be integrated with the K8S

### Step 1 - Deploy the application**

`kubectl create ns yelb`

`kubectl apply -f https://github.com/atozprasad/cna/blob/master/k8s/k8s-examples/multi-tier-apps/yelb/yelb-lb.yaml`

### Step 2 Exaplore the resources been deployed**

`kubectl -n yelb get pods,deployment,svc`
Note: You should see the pods in the satus *Ready*.

### Step 3 Fech access details**

`kubectl -n yelb  svc/yelb-ui -o wide`
Note : You should have the IP address for the Service at ExternalIP coloumn

### Step 4 Access App**

From the Browswer http://< ExternalIP >:
Note : You should have the IP address for the Service at ExternalIP coloumn
