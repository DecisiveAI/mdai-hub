# Prometheus Usage

We use [Prometheus](https://prometheus.io/) for self-monitoring and storing metrics.

## What does my configmap look like?

Find your prometheus configmap

```bash
kubectl -n mdai get configmaps | grep prometheus
```

Copy the configmap name from the last command and enter it below.

```bash
kubectl -n mdai get configmaps --selector app.kubernetes.io/name=prometheus-###### -o yaml
```

## Prometheus settings

There are more advanced configs you can review 
- [Example Prometheus Alert Manager Rule](../example_prometheus_rule.yaml)

## Data Persistence - Prometheus

>⚠️⚠️⚠️ By default there is no data persistence for Prometheus. If you destroy your MDAI Cluster, you'll also be destroying your prometheus instance and all associated data. ⚠️⚠️⚠️

To set up Prometheus persistence check PV.md

----

<br />

[Back to README.md](../README.md)

