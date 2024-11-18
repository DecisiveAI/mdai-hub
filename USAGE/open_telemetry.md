# OpenTelemetry Usage

We use OTel's [contrib](https://github.com/open-telemetry/opentelemetry-collector-contrib) repo. Any usage should can be found in the OTel [docs site](https://opentelemetry.io/docs/what-is-opentelemetry/)


## What does my configmap look like?

> Note: The pod name `gateway-collector-####` can be found using autocomplete

```sh
kubectl -n mdai get configmaps --selector app.kubernetes.io/name=gateway-collector -o yaml
```

----
<br />


[Back to README.md](../../README.md)

