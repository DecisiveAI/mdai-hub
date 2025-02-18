# Persistent Storage

## Prometheus

In order to enable persistent storage for Prometheus, uncomment the following block in 
Prometheus section (`kubeprometheusstack.prometheus.prometheusSpec`) of [values.yaml](./values.yaml):

```yaml
     #  securityContext:
     #    fsGroup: 65534
     #    runAsGroup: 65534
     #    runAsNonRoot: true
     #    runAsUser: 65534
     #  initContainers:
     #  - name: prometheus-data-permission-setup
     #    image: busybox
     #    securityContext:
     #      runAsGroup: 0
     #      runAsNonRoot: false
     #      runAsUser: 0
     #      fsGroup: 0
     #    command: ["/bin/chown","-R","65534:65534","/prometheus"]
     #    volumeMounts:
     #    - name: prometheus-kube-prometheus-stack-prometheus-db
     #      mountPath: /prometheus
     #  storageSpec:
     #    volumeClaimTemplate:
     #      spec:
     #        storageClassName: ""
     #        accessModes: ["ReadWriteOnce"]
     #        resources:
     #          requests:
     #            storage: 5Gi
```
With `securityContext` section we set `uid/guid` Prometheus instance will be running with.

With `InitContainers` section we set add `initContainer`, that fixes permissions for `/prometheus` mount point.

Please refer to the  original `kube-prometheus-stack` [values.yaml](https://github.com/prometheus-community/helm-charts/blob/65b61ef0c2ac8eca52d9b69aca3df8541f6ceb6f/charts/kube-prometheus-stack/values.yaml#L4134)
for more `storageSpec` details

## Valkey

In order to enable persistent storage for Valkey, do the following:
- uncomment the following lines in the Valkey block (`valkey.primary`) [values.yaml](./values.yaml):
```yaml
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
```
- change `valkey.primary.persistence` to `true` in  [values.yaml](./values.yaml):
```yaml
    persistence:
      # set to true to enable persistent storage
      enabled: false
```
