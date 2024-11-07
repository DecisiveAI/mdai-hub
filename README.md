# TESTING

This sets up a cluster with the MDAI stack + Fluentd + Minio. It:

- Stores all ERROR/WARNING logs in minio
- Filters any service's INFO logs that sends more than 5MB in the last 6 minutes
- Spins up some little log generators that will appear to send logs for 1001 services
  - service9999 will be really noisy
  - More can be spun up using the example_log_generator manifests

## Make cluster

    kind create cluster --name cheggtober

## Install minio

    helm upgrade --install --repo https://charts.min.io minio minio -f values_minio.yaml

### install of MDAI without cert-manager

    helm dependency update && helm upgrade --install --create-namespace --namespace mdai --cleanup-on-fail --wait-for-jobs -f values.yaml -f values_prometheus.yaml mdai .

## Init a collector

> Note: must be in `mdai` namespace with the datalyzer

    kubectl apply -f ./example_collector.yaml --namespace mdai

## Install a couple of log generators

    kubectl apply -f ./example_log_generator.yaml -f ./example_log_generator_noisy_service.yaml

## Install fluentd

    helm upgrade --install --repo https://fluent.github.io/helm-charts fluent fluentd -f values_fluentd.yaml
