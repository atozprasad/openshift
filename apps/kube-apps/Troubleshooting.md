# Steps followed in order to make it work for Openshift

- Copy the Helm chart to your loc
- We need to fetch all the images
- Tag them as our repo name
- Push them to our local repo
- Identify the service accounts created by this app and add them to the SCC user 



#Activities performed
`helm 
#Issues encountered
-----------------
## Issue 1 - Pods not getting created

- **Check K8s events to understand the insights**

``
[root@ocp-jump kube-apps]# kubectl get events
LAST SEEN   TYPE      REASON              OBJECT                                                             MESSAGE
8m7s        Warning   FailedCreate        replicaset/kubeapps-558c549647                                     Error creating: pods "kubeapps-558c549647-" is forbidden: unable to validate against any security context constraint: [provider restricted: .spec.securityContext.fsGroup: Invalid value: []int64{1001}: 1001 is not an allowed group spec.containers[0].securityContext.runAsUser: Invalid value: 1001: must be in the ranges: [1000740000, 1000749999]]
5s          Warning   FailedCreate        replicaset/kubeapps-558c549647                                     Error creating: pods "kubeapps-558c549647-" is forbidden: unable to validate against any security context constraint: [provider restricted: .spec.securityContext.fsGroup: Invalid value: []int64{1001}: 1001 is not an allowed group spec.containers[0].securityContext.runAsUser: Invalid value: 1001: must be in the ranges: [1000740000, 1000749999]]
8m6s        Warning   FailedCreate        replicaset/kubeapps-internal-apprepository-controller-59ff4487d6   Error creating: pods "kubeapps-internal-apprepository-controller-59ff4487d6-" is forbidden: unable to validate against any security context constraint: [provider restricted: .spec.securityContext.fsGroup: Invalid value: []int64{1001}: 1001 is not an allowed group spec.containers[0].securityContext.runAsUser: Invalid value: 1001: must be in the ranges: [1000740000, 1000749999]]
4s          Warning   FailedCreate        replicaset/kubeapps-internal-apprepository-controller-59ff4487d6   Error creating: pods "kubeapps-internal-apprepository-controller-59ff4487d6-" is forbidden: unable to validate against any security context constraint: [provider restricted: .spec.securityContext.fsGroup: Invalid value: []int64{1001}: 1001 is not an allowed group spec.containers[0].securityContext.runAsUser: Invalid value: 1001: must be in the ranges: [1000740000, 1000749999]]
2m49s       Normal    ScalingReplicaSet   deployment/kubeapps-internal-apprepository-controller              Scaled up replica set kubeapps-internal-apprepository-controller-59ff4487d6 to 1
8m7s        Warning   FailedCreate        replicaset/kubeapps-internal-assetsvc-79587885c5                   Error creating: pods "kubeapps-internal-assetsvc-79587885c5-" is forbidden: unable to validate against any security context constraint: [provider restricted: .spec.securityContext.fsGroup: Invalid value: []int64{1001}: 1001 is not an allowed group spec.containers[0].securityContext.runAsUser: Invalid value: 1001: must be in the ranges: [1000740000, 1000749999]]
4s          Warning   FailedCreate        replicaset/kubeapps-internal-assetsvc-79587885c5                   Error creating: pods "kubeapps-internal-assetsvc-79587885c5-" is forbidden: unable to validate against any security context constraint: [provider restricted: .spec.securityContext.fsGroup: Invalid value: []int64{1001}: 1001 is not an allowed group spec.containers[0].securityContext.runAsUser: Invalid value: 1001: must be in the ranges: [1000740000, 1000749999]]
2m49s       Normal    ScalingReplicaSet   deployment/kubeapps-internal-assetsvc                              Scaled up replica set kubeapps-internal-assetsvc-79587885c5 to 1
8m7s        Warning   FailedCreate        replicaset/kubeapps-internal-dashboard-6d4f46fb76                  Error creating: pods "kubeapps-internal-dashboard-6d4f46fb76-" is forbidden: unable to validate against any security context constraint: [provider restricted: .spec.securityContext.fsGroup: Invalid value: []int64{1001}: 1001 is not an allowed group spec.containers[0].securityContext.runAsUser: Invalid value: 1001: must be in the ranges: [1000740000, 1000749999]]
4s          Warning   FailedCreate        replicaset/kubeapps-internal-dashboard-6d4f46fb76                  Error creating: pods "kubeapps-internal-dashboard-6d4f46fb76-" is forbidden: unable to validate against any security context constraint: [provider restricted: .spec.securityContext.fsGroup: Invalid value: []int64{1001}: 1001 is not an allowed group spec.containers[0].securityContext.runAsUser: Invalid value: 1001: must be in the ranges: [1000740000, 1000749999]]
2m49s       Normal    ScalingReplicaSet   deployment/kubeapps-internal-dashboard                             Scaled up replica set kubeapps-internal-dashboard-6d4f46fb76 to 2
8m7s        Warning   FailedCreate        replicaset/kubeapps-internal-kubeappsapis-84bfdc69f9               Error creating: pods "kubeapps-internal-kubeappsapis-84bfdc69f9-" is forbidden: unable to validate against any security context constraint: [provider restricted: .spec.securityContext.fsGroup: Invalid value: []int64{1001}: 1001 is not an allowed group spec.containers[0].securityContext.runAsUser: Invalid value: 1001: must be in the ranges: [1000740000, 1000749999]]
4s          Warning   FailedCreate        replicaset/kubeapps-internal-kubeappsapis-84bfdc69f9               Error creating: pods "kubeapps-internal-kubeappsapis-84bfdc69f9-" is forbidden: unable to validate against any security context constraint: [provider restricted: .spec.securityContext.fsGroup: Invalid value: []int64{1001}: 1001 is not an allowed group spec.containers[0].securityContext.runAsUser: Invalid value: 1001: must be in the ranges: [1000740000, 1000749999]]
2m49s       Normal    ScalingReplicaSet   deployment/kubeapps-internal-kubeappsapis                          Scaled up replica set kubeapps-internal-kubeappsapis-84bfdc69f9 to 1
8m7s        Warning   FailedCreate        replicaset/kubeapps-internal-kubeops-657cd8d74b                    Error creating: pods "kubeapps-internal-kubeops-657cd8d74b-" is forbidden: unable to validate against any security context constraint: [provider restricted: .spec.securityContext.fsGroup: Invalid value: []int64{1001}: 1001 is not an allowed group spec.containers[0].securityContext.runAsUser: Invalid value: 1001: must be in the ranges: [1000740000, 1000749999]]
4s          Warning   FailedCreate        replicaset/kubeapps-internal-kubeops-657cd8d74b                    Error creating: pods "kubeapps-internal-kubeops-657cd8d74b-" is forbidden: unable to validate against any security context constraint: [provider restricted: .spec.securityContext.fsGroup: Invalid value: []int64{1001}: 1001 is not an allowed group spec.containers[0].securityContext.runAsUser: Invalid value: 1001: must be in the ranges: [1000740000, 1000749999]]
2m49s       Normal    ScalingReplicaSet   deployment/kubeapps-internal-kubeops                               Scaled up replica set kubeapps-internal-kubeops-657cd8d74b to 2
8m6s        Warning   FailedCreate        statefulset/kubeapps-postgresql-primary                            create Pod kubeapps-postgresql-primary-0 in StatefulSet kubeapps-postgresql-primary failed error: pods "kubeapps-postgresql-primary-0" is forbidden: unable to validate against any security context constraint: [spec.containers[0].securityContext.runAsUser: Invalid value: 1001: must be in the ranges: [1000740000, 1000749999]]
4s          Warning   FailedCreate        statefulset/kubeapps-postgresql-primary                            create Pod kubeapps-postgresql-primary-0 in StatefulSet kubeapps-postgresql-primary failed error: pods "kubeapps-postgresql-primary-0" is forbidden: unable to validate against any security context constraint: [spec.containers[0].securityContext.runAsUser: Invalid value: 1001: must be in the ranges: [1000740000, 1000749999]]
8m7s        Warning   FailedCreate        statefulset/kubeapps-postgresql-read                               create Pod kubeapps-postgresql-read-0 in StatefulSet kubeapps-postgresql-read failed error: pods "kubeapps-postgresql-read-0" is forbidden: unable to validate against any security context constraint: [spec.containers[0].securityContext.runAsUser: Invalid value: 1001: must be in the ranges: [1000740000, 1000749999]]
4s          Warning   FailedCreate        statefulset/kubeapps-postgresql-read                               create Pod kubeapps-postgresql-read-0 in StatefulSet kubeapps-postgresql-read failed error: pods "kubeapps-postgresql-read-0" is forbidden: unable to validate against any security context constraint: [spec.containers[0].securityContext.runAsUser: Invalid value: 1001: must be in the ranges: [1000740000, 1000749999]]
2m49s       Normal    ScalingReplicaSet   deployment/kubeapps                                                Scaled up replica set kubeapps-558c549647 to 2
``

- **Add necessary privillages to th for the security constrain Check K8s events to understand the insights**

oc adm policy add-scc-to-user anyuid -n kubeapps -z  admin

- **in the values.yaml file change fsGropu value form 1001 to one of the validate range shown in the events warning message (i.e. ranges: [1000740000, 1000749999]] )**
    Updated : fsGroup: 1000740000
-----------------


## Accessing Kubeapps Ingress LB

``
#pick the EXTERNAL-IP value for the kubeappslb service  and use it in the browser
kubectl get svc 

[root@ocp-jump kubeapps]# kubectl get svc
NAME                             TYPE           CLUSTER-IP       EXTERNAL-IP     PORT(S)        AGE
kubeapps                         ClusterIP      172.30.114.59    <none>          80/TCP         58m
kubeapps-internal-assetsvc       ClusterIP      172.30.201.163   <none>          8080/TCP       58m
kubeapps-internal-dashboard      ClusterIP      172.30.162.201   <none>          8080/TCP       58m
kubeapps-internal-kubeappsapis   ClusterIP      172.30.30.176    <none>          8080/TCP       58m
kubeapps-internal-kubeops        ClusterIP      172.30.83.50     <none>          8080/TCP       58m
kubeapps-postgresql              ClusterIP      172.30.80.123    <none>          5432/TCP       58m
kubeapps-postgresql-headless     ClusterIP      None             <none>          5432/TCP       58m
kubeapps-postgresql-read         ClusterIP      172.30.235.252   <none>          5432/TCP       58m
kubeappslb                       LoadBalancer   172.30.65.57     10.159.231.71   80:30087/TCP   26h
``

WARNING: Kubernetes configuration file is group-readable. This is insecure. Location: /root/openshift/deploy/auth/kubeconfig
NAME: kubeapps
LAST DEPLOYED: Wed Dec  1 14:31:26 2021
NAMESPACE: kubeapps
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:
CHART NAME: kubeapps
CHART VERSION: 7.5.10
APP VERSION: 2.4.1** Please be patient while the chart is being deployed **

Tip:

  Watch the deployment status using the command: kubectl get pods -w --namespace kubeapps

Kubeapps can be accessed via port 80 on the following DNS name from within your cluster:

   kubeapps.kubeapps.svc.cluster.local

To access Kubeapps from outside your K8s cluster, follow the steps below:

1. Get the Kubeapps URL by running these commands:
   echo "Kubeapps URL: http://127.0.0.1:8080"
   kubectl port-forward --namespace kubeapps service/kubeapps 8080:80

2. Open a browser and access Kubeapps using the obtained URL.

##########################################################################################################
### WARNING: You did not provide a value for the postgresqlPassword so one has been generated randomly ###
##########################################################################################################
[root@ocp-jump kube-apps]#



