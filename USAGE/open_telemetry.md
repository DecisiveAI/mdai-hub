# OpenTelemetry Usage

We use OTel's [contrib](https://github.com/open-telemetry/opentelemetry-collector-contrib) repo. Any usage should can be found in the OTel [docs site](https://opentelemetry.io/docs/what-is-opentelemetry/)


## What does my config look like?

> Note: The pod name `gateway-collector-####` can be found using autocomplete

```sh
kubectl -n mdai get configmaps gateway-collector-##### -o yaml
```