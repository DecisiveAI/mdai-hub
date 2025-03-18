# MDAI Helm chart

This is the official Helm chart for [MyDecisive.ai](https://www.mydecisive.ai/), an open-core solution for monitoring and managing OpenTelemetry pipelines on Kubernetes.

## MDAI Lifecycle Management - Automated

### Run dependency pre-flight check

Ensure your environment is set up correctly before deployment

```bash
make preflight_check
```

### Install chart

If all pre-flight checks pass, you can install mdai.

```bash
make install_helm_chart
```

### Uninstall helm chart

If you need to uninstall mdai

```bash
make uninstall_helm_chart
```

## Install MDAI - Manual

```bash
helm upgrade --install --repo https://decisiveai.github.io/mdai-helm-charts mdai mdai-hub
```

... *alternatively if you've already installed, you can update the chart.*

```bash
helm repo add mdai https://decisiveai.github.io/mdai-helm-charts
helm repo update
```

### With cert-manager

```bash
helm upgrade --install --repo https://decisiveai.github.io/mdai-helm-charts --create-namespace --namespace mdai --cleanup-on-fail --wait-for-jobs --set mdai-operator.webhooks.certManager.enabled=true --set mdai-operator.webhooks.autoGenerateCert.enabled=false mdai mdai-hub

### Without Prometheus operator/CRDs

```bash
helm upgrade --install --repo https://decisiveai.github.io/mdai-helm-charts --create-namespace --namespace mdai --cleanup-on-fail --wait-for-jobs --set kubeprometheusstack.crds.enabled=false --set kubeprometheusstack.prometheusOperator.enabled=false --set kubeprometheusstack.nodeExporter.enabled=false mdai mdai-hub
```

When this option is chosen, make sure existing Prometheus Operator's configuration allows to manage Custom Resources in the above namespace
Prometheus NodeExporter  installation is disabled as it's considered deployed along with the Prometheus Operator.

### Without Prometheus CRDs. Prometheus Operator will be installed.

```bash
helm upgrade --install --repo https://decisiveai.github.io/mdai-helm-charts --create-namespace --namespace mdai --cleanup-on-fail --wait-for-jobs --set kubeprometheusstack.crds.enabled=false --set kubeprometheusstack.nodeExporter.enabled=false mdai mdai-hub
```

When this option is chosen, make sure existing Prometheus Operator's configuration allows to manage Custom Resources in the above namespace
Prometheus NodeExporter  installation is disabled as it's considered deployed along with the Prometheus Operator.


### Without Grafana

```bash
helm upgrade --install --repo https://decisiveai.github.io/mdai-helm-charts --create-namespace --namespace mdai --cleanup-on-fail --wait-for-jobs -f without_grafana.yaml mdai mdai-hub
```

### Without cleanup on uninstall

```bash
helm upgrade --install --repo https://decisiveai.github.io/mdai-helm-charts --create-namespace --namespace mdai --cleanup-on-fail --wait-for-jobs --set cleanup=false mdai mdai-hub
```

### Other Install mechanisms

see `values.yaml` for other options.


## Learn more

* Visit our [solutions page](https://www.mydecisive.ai/solutions) for more details MyDecisive's approach to composable observability.
* Head to our [docs](https://docs.mydecisive.ai/) to learn more about MyDecisive's tech.

## Info and Support

* Contact [support@mydecisive.ai](mailto:support@mydecisive.ai) for assistance or to talk to with a member of our support team
* Contact [info@mydecisive.ai](mailto:info@mydecisive.ai) if you're interested in learning more about our solutions
