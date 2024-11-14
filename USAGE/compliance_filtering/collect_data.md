## Create and use OTel collector for forwarding logs

> Note: must be in `mdai` namespace with the datalyzer

```sh
# add a collector definition 
kubectl apply -f ./example_collector.yaml --namespace mdai
```



> Note:  you can likely autocomplete with your terminal to get your collector's pod name

```sh
kubectl -o wide -n mdai get pods --selector app.kubernetes.io/name=gateway-collector
```

### Ensure your collector pod is up and running. 

You can review your collector config by running the following command: 

```sh
kubectl -n mdai get configmaps --selector app.kubernetes.io/name=gateway-collector -o yaml
```

The output should contain the same `yaml` block that is displayed in the `example_collector.yaml`.


## Collector ready for use!

You now have fake data that's being generated and logged. Your next step will be to set up a collector that the logs can be sent to.

----

<br />
<br />

[Next step: Forward logs to OTel!](./forward_data.md)
