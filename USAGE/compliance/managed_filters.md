# Enabling Managed filters

If you view the [example_collector.yaml](../../example_collector.yaml), you'll notice that there is a block in the config under filters where the filter `mute-noisy-services` is false. 

```yaml
telemetryFiltering:
  filters:
    - name: mute-noisy-services
      enabled: false
      description: filter noisy services
      managedFilter:
        pipelines:
          - logs/customer_pipeline
        filterProcessorConfig:
          logs:
            log_record:
              - 'IsMatch(resource.attributes["service.name"], "<<SERVICE_LIST>>") and attributes["log_level"] == "INFO"'
        alertingRules:
          - name: noisy-service-threshold
            alert_query: 'increase(mdai_log_bytes_received_total{service_name!=""}[6m]) > 5 * 1024 * 1024'
            for: 1m
            severity: warning
            action: manageFilter
```

Let's enable the filter in [example_collector.yaml](../../example_collector.yaml) by changing `enabled: false` to `enabled: true`


### Update the config in your collector

```sh
kubectl apply -f ./example_collector.yaml
```


### Validate

You can validate that your collector config changed by running the following command

```sh
kubectl -n mdai get configmaps gateway-collector-##### -o yaml
```

### Let's see it in action

You should be able to jump back over to prometheus and start an investigation for offending service. 

---- 

Next up: [Enabling Managed Filters ➡](./investigate_offenders.md)



