### install of MDAI without cert-manager

    helm upgrade --install --create-namespace --namespace mdai --cleanup-on-fail --dependency-update --wait-for-jobs -f values.yaml -f values_prometheus.yaml mdai .

### install of MDAI with cert-manager

    helm upgrade --install --create-namespace --namespace mdai --cleanup-on-fail --dependency-update --wait-for-jobs --set mdai-operator.webhooks.certManager.enabled=true --set mdai-operator.webhooks.autoGenerateCert.enabled=false -f values.yaml -f values_prometheus.yaml mdai .

### install of MDAI without cleanup on uninstall

    helm upgrade --install --create-namespace --namespace mdai --cleanup-on-fail --dependency-update --wait-for-jobs --set cleanup=false -f values.yaml -f values_prometheus.yaml mdai .

see `values.yaml` for other options.

# TESTING

## Install prometheus rules

    kubectl apply -f ./example_prometheus_rule.yaml

## Install a log generator

    kubectl apply -f ./example_log_generator.yaml
    kubectl apply -f ./example_log_generator_noisy_service.yaml

## Init a collector

> Note: must be in `mdai` namespace with the datalyzer

    kubectl apply -f ./example_collector.yaml --namespace mdai

## Install fluentd

    helm repo add fluent https://fluent.github.io/helm-charts && helm repo update
    helm install fluentd fluent/fluentd --values values_fluentd.yaml
