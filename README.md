### install of MDAI without cert-manager

    helm upgrade --install --create-namespace --namespace mdai --cleanup-on-fail --dependency-update --wait-for-jobs -f values.yaml -f values_prometheus.yaml mdai .

### install of MDAI with cert-manager

    helm upgrade --install --create-namespace --namespace mdai --cleanup-on-fail --dependency-update --wait-for-jobs --set mdai-operator.webhooks.certManager.enabled=true --set mdai-operator.webhooks.autoGenerateCert.enabled=false -f values.yaml -f values_prometheus.yaml mdai .

### install of MDAI without cleanup on uninstall

    helm upgrade --install --create-namespace --namespace mdai --cleanup-on-fail --dependency-update --wait-for-jobs --set cleanup=false -f values.yaml -f values_prometheus.yaml mdai .

see `values.yaml` for other options.

# TESTING

## Make cluster

    kind create cluster --name cheggtober

## Add helm repos

    helm repo add minio https://charts.min.io/
    helm repo add fluent https://fluent.github.io/helm-charts
    helm repo update

## Install minio

    helm install minio minio/minio --values values_minio.yaml

### install of MDAI without cert-manager

    helm upgrade --install --create-namespace --namespace mdai --cleanup-on-fail --dependency-update --wait-for-jobs -f values.yaml -f values_prometheus.yaml mdai .

## Install a log generator

    kubectl apply -f ./example_log_generator.yaml
    kubectl apply -f ./example_log_generator_noisy_service.yaml

## Init a collector

> Note: must be in `mdai` namespace with the datalyzer

    kubectl apply -f ./example_collector.yaml --namespace mdai

## Install fluentd

    helm install fluentd fluent/fluentd --values values_fluentd.yaml
