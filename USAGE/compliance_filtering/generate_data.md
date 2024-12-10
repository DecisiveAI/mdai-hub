## Create and initialize log generators 

You will spin up three different mock data generators to see data flowing through your pipelines. 

*** _**Please run all the generators to ensure you have data that will demonstrate functionality at the end of this use case.**_ ***

### Generator 1

A normal and consistent log generator for random number generated service names `service####`.

```bash
kubectl apply -f ./example_log_generator.yaml
```

You should be able to view the log output to validate the generation of logs. See [Validating generators](#validating-generators) section.

<video controls src="../../media/logs_normal.mp4"></video>

### Generator 2

A noisy log generator of logs for a particular service (`service1234` unless changed)

```bash
kubectl apply -f ./example_log_generator_noisy_service.yaml
```

You should be able to view the log output to validate the generation of logs. See [Validating generators](#validating-generators) section.

<video controls src="../../media/logs_noisy.mp4"></video>

### Generator 3

A noisy and excessive log generator of logs for a particular service (`service4321` unless changed)

```bash
kubectl apply -f ./example_log_generator_xtra_noisy_service.yaml
```

You should be able to view the log output to validate the generation of logs. See [Validating generators](#validating-generators) section.

<video controls src="../../media/log_xtra_noisy.mp4"></video>


### Validating generators

### Using k9s

You can use k9s (our preferred method) to view logs 

1. From your terminal, use the `k9s` command to launch k9s
2. Given you're in the correct cluster and namespace, select the pod using the arrow keys, and hit `l` once you've highlighted the pod you'd like to inspect logs for. You should see log output.

### Using kubectl

If you'd prefer to use `kubectl`, for viewing logs, you can run the following command:

```bash
# list all pods 
kubectl get pods -n mdai -l app.kubernetes.io/part-of=mdai-log-generator

# view logs for a given generator
kubectl get pods -n mdai -l app.kubernetes.io/name=loggy-mclogface # normal
kubectl get pods -n mdai -l app.kubernetes.io/name=noisy-mclogface # noisy
kubectl get pods -n mdai -l app.kubernetes.io/name=xtra-noisy-logz # extra noisy
```

## Data generated!

You now have fake data that's being generated and logged. Your next step will be to set up a collector that the logs can be sent to.

----

<br />
<br />

[Next step: Collect data with OTel!](./collect_data.md)