## Investigate alerts

We previously set up alert settings as part of the managed filters. Let's validate your alerts are configured. 

### Alert Statuses

There are three statuses that your alerts can enter
1. Inactive
2. Pending
3. Firing

### View an alert

You should be able to navigate to your <a href="http://localhost:9090/alerts?search=" target="_blank">Prometheus Alerts</a> to view all configure alerts regardless of the status of the alert. 

You should see a  `noisy-service-threshold` alert, albeit, not necessarily in the state `Firing`.

<a href="../../media/prom_alert_page.png" target="_blank">
  <img alt="prometheus alerts" src="../../media/prom_alert_page.png" />
</a>

Depending on your generators, you will be in any one of these states at any given time. 

#### Run alert query

>Note: You may need to wait for some time for an alert to become active, in the `Firing` state. 

You can expand the `noisy-service-threshold` alert and click on the `expr` query. 

<a href="../../media/prom_alert_inspect.png" target="_blank">
  <img alt="prometheus alerts" src="../../media/prom_alert_inspect.png" />
</a>

This is a quick <a href="http://localhost:9090/graph?g0.expr=increase(mdai_log_bytes_received_total%7Bservice_name!%3D%22%22%7D%5B6m%5D)%20%3E%205%20*%201024%20*%201024&g0.tab=0&g0.display_mode=lines&g0.show_exemplars=0&g0.range_input=1h" target="_blank">Alert Query Link</a> that will take you to the graph view of an alert. It should look like the following result.


<a href="../../media/alert_query_graph.png" target="_blank">
  <img alt="prometheus alerts" src="../../media/alert_query_graph.png" />
</a>

The result will validate the threshold of 5MB over a 6-minute time window being surpassed. 

### Congrats!

Hooray 🎉. You've successfully made it through the full workflow for this use case. 

----

[Back to README.md](../../README.md)






