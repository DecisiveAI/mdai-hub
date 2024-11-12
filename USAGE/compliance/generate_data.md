## Create and initialize log generators

You will install three different mock data generators to see data flowing through your pipelines. 

### Generator 1

A normal and consistent log generator for random number generated service names `service####`.

```sh
kubectl apply -f ./example_log_generator.yaml
```

You should be able to view the log output to validate the generation of logs.

<video controls src="../media/logs_normal.mp4"></video>

### Generator 2

A noisy log generator of logs for a particular service (`service1234` unless changed)

```sh
kubectl apply -f ./example_log_generator_noisy_service.yaml
```

You should be able to view the log output to validate the generation of logs.

<video controls src="../media/logs_noisy.mp4"></video>

### Generator 3

A noisy and excessive log generator of logs for a particular service (`service4321` unless changed)

```sh
kubectl apply -f ./example_log_generator_xtra_noisy_service.yaml
```

You should be able to view the log output to validate the generation of logs.

<video controls src="../media/log_xtra_noisy.mp4"></video>


## Data generated!

You now have fake data that's being generated and logged. Your next step will be to set up a collector that the logs can be sent to.

----

<br />
<br />

[Next step: Collect data with OTel!](./collect_data.md)