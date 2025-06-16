# MDAI Helm chart

This is the official Helm chart for [MyDecisive.ai](https://www.mydecisive.ai/), an open-core solution for monitoring and managing OpenTelemetry pipelines on Kubernetes.

_After initial checkout, switching branches or modifying `Chart.yaml`, run `helm dependency update . --repository-config /dev/null`_

## Prerequisites
- Kubernetes 1.24+
- Helm 3.9+
- [cert-manager](https://cert-manager.io/docs/)

## Add Helm repository
```bash
helm repo add mdai https://decisiveai.github.io/mdai-helm-charts
helm repo update
```
_See [`helm repo`](https://helm.sh/docs/helm/helm_repo/) for command documentation._

## Install MDAI helm chart
```bash
helm upgrade --install --create-namespace --namespace mdai --cleanup-on-fail --wait-for-jobs mdai mdai/mdai-hub
```

## Learn more

* Visit our [solutions page](https://www.mydecisive.ai/solutions) for more details MyDecisive's approach to composable observability.
* Head to our [docs](https://docs.mydecisive.ai/) to learn more about MyDecisive's tech.

## Info and Support

Please contact us via our Community Slack channels

* [#mdai-community-discussion](https://mydecisivecommunity.slack.com/archives/C08LE3DJ877) - All discussion
* [#mdai-docs-questions](https://mydecisivecommunity.slack.com/archives/C090KU6F679) - Questions about docs
* [#mdai-feature-requests](https://mydecisivecommunity.slack.com/archives/C090UH3JYNS) - Raising a request for new capabilities
* [#mdai-platform-support](https://mydecisivecommunity.slack.com/archives/C090KU1MB6K) - Assistance with using MDAI
