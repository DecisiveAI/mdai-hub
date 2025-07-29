# Persistent Storage

## Prometheus

Prometheus operator does not allow to specify an existing PVC, so make sure you PV satisfied a Prometheus PVC requirements
In order to enable persistent storage for Prometheus, uncomment the following block in 
Prometheus section (`kubeprometheusstack.prometheus.prometheusSpec`) of [values.yaml](./values.yaml):

```yaml
      ## uncomment below block to enable persistent storage
      ## BEGIN: persistent storage block
      #nodeSelector:
      #  topology.kubernetes.io/zone: us-east-1a
      #securityContext:
      #  fsGroup: 65534
      #  runAsGroup: 65534
      #  runAsNonRoot: true
      #  runAsUser: 65534
      #initContainers:
      #- name: prometheus-data-permission-setup
      #  image: busybox
      #  securityContext:
      #    runAsGroup: 0
      #    runAsNonRoot: false
      #    runAsUser: 0
      #  command: ["/bin/chown","-R","65534:65534","/prometheus"]
      #  volumeMounts:
      #  - name: prometheus-kube-prometheus-stack-prometheus-db
      #    mountPath: /prometheus
      #storageSpec:
      #  volumeClaimTemplate:
      #    spec:
      #      storageClassName: gp2
      #      accessModes: ["ReadWriteOnce"]
      #      volumeName: pv-prometheus
      #      resources:
      #        requests:
      #          storage: 10Gi
      ## END: persistent storage block  
```
With `securityContext` section we set `uid/guid` Prometheus instance will be running with.

With `InitContainers` section we set add `initContainer`, that fixes permissions for `/prometheus` mount point.

Please refer to the  original `kube-prometheus-stack` [values.yaml](https://github.com/prometheus-community/helm-charts/blob/65b61ef0c2ac8eca52d9b69aca3df8541f6ceb6f/charts/kube-prometheus-stack/values.yaml#L4134)
for more `storageSpec` details

## Valkey

In order to enable persistent storage for Valkey, do the following:
- uncomment the following lines in the Valkey block (`valkey.primary`) [values.yaml](./values.yaml):
```yaml
    ## uncomment below block to enable persistent storage
    ## BEGIN: persistent storage block
    #nodeSelector:
    #  topology.kubernetes.io/zone: us-east-1a
    #initContainers:
    #- command:
    #  - /bin/chown
    #  - -R
    #  - 1001:1001
    #  - /data
    #  image: busybox
    #  name: valkey-data-permission-setup
    #  securityContext:
    #    runAsGroup: 0
    #    runAsNonRoot: false
    #    runAsUser: 0
    #  volumeMounts:
    #  - mountPath: /data
    #    name: valkey-data
    ## END: persistent storage block    
    replicaCount: 1
    persistence:
      enabled: false
      ## uncomment below block to enable persistent storage
      ## BEGIN: persistent storage block
      #enabled: true
      #size: 10Gi
      #existingClaim: pvc-valkey
      ## END: persistent storage block    
```
- change `valkey.primary.persistence` to `true` in  [values.yaml](./values.yaml):
```yaml
    persistence:
      # set to true to enable persistent storage
      enabled: false
```

## NATS

### Kind

1. Create 3 PersistentVolume resources in your Kind cluster:
```yaml
apiVersion: v1
kind: PersistentVolume
metadata:
  name: nats-pv-0 # nats-pv-1, nats-pv-1 should be created too
spec:
  storageClassName: mdai # storageClassName here and in PVC should match 
  capacity:
    storage: 1Gi # choose a size
  accessModes:
    - ReadWriteOnce
  hostPath:
    path: /path/to/local/directory # this is where you want you volume resides
```

2. Update [values.yaml](./values.yaml) as follows (see comments within the file itself):
```yaml
      fileStore:
        enabled: true
          dir: "/data/jetstream"
          pvc:
            enabled: true
            storageClassName: "mdai"  # should match PV's value
            size: 1Gi # should match PV's value
```
3 PVCs will be created

### AWS
Prerequisites:
[AWS EBS CSI driver](https://aws.amazon.com/blogs/containers/amazon-ebs-csi-driver-is-now-generally-available-in-amazon-eks-add-ons/) must be installed on the cluster



##### Static provisioning
1. On AWS create 3 EBS volumes of the desired size. Preferably these volumes should reside in different availability zones (but only in those, your EKS cluster run on)
2. In your EKS cluster create 3 PersistentVolumes for the above EBS volumes:
```yaml
apiVersion: v1
kind: PersistentVolume
metadata:
  name: nats-pv-0
spec:
  capacity:
    storage: 1Gi # should be equal to your volume size
  accessModes:
    - ReadWriteOnce
  persistentVolumeReclaimPolicy: Retain
  storageClassName: mdai # storageClassName here and in PVC should match 
  csi:
    driver: ebs.csi.aws.com
    volumeHandle: vol-0d7cae9c14877a168 # specify EBS volume Id
  nodeAffinity:
    required:
      nodeSelectorTerms:
        - matchExpressions:
            - key: topology.kubernetes.io/zone
              operator: In
              values:
                - us-east-1a # specify EBS volune's az
 ```
3. Update [values.yaml](./values.yaml) as follows (see comments in the file itself as well):
```yaml
      fileStore:
        enabled: true
          dir: "/data/jetstream"
          pvc:
            enabled: true
            storageClassName: "mdai"  # should match PV value
            size: 1Gi # should match PV value
```

##### Dynamic provisioning
Update [values.yaml](./values.yaml) as follows (see comments in the file itself as well):
```yaml
      fileStore:
        enabled: true
          dir: "/data/jetstream"
          pvc:
            enabled: true
            storageClassName: "mdai"
            size: 1Gi # desired size
```
PersistentVolumeClaims  will be created, and CSI driver will do the rest - provision volumes, creates PersistentVolumes resources 
