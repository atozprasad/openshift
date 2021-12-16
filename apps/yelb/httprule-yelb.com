apiVersion: ako.vmware.com/v1alpha1
kind: HTTPRule
metadata:
   name: yelb-httprule
spec:
  fqdn:  yelbhttps.apps.ocp-cl03.vmware.ocpeval.scstec.net
  paths:
  - target: /*
    applicationPersistence: System-Persistence-Client-IP
    healthMonitors:
    - yelb-tcp-halfopen-monitor
    loadBalancerPolicy:
      algorithm: LB_ALGORITHM_CONSISTENT_HASH
      hash: LB_ALGORITHM_CONSISTENT_HASH_SOURCE_IP_ADDRESS
