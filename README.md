# MDAI Hub

[![Artifact Hub](https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/mdai-hub)](https://artifacthub.io/packages/search?repo=mdai-hub)

This is the official Helm chart for [MyDecisive.ai](https://www.mydecisive.ai/), an open-core solution for monitoring and managing OpenTelemetry pipelines on Kubernetes.

_After initial checkout, switching branches or modifying `Chart.yaml`, run `helm dependency update . --repository-config /dev/null`_

## Prerequisites
- Kubernetes 1.24+
- Helm 3.9+
- [cert-manager](https://cert-manager.io/docs/)

## Install MDAI Hub helm chart
```bash
helm upgrade --install \
  --repo https://charts.mydecisive.ai \
  --namespace mdai \
  --create-namespace \
  --cleanup-on-fail \
  --devel \
  mdai mdai-hub
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
