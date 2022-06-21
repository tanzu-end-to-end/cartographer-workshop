##### Time to Deploy! (Developer Perspective)

###### Apply Workload

Recall the Workload definition you created earlier.

```editor:open-file
file: /home/eduk8s/exercises/workload.yaml
```

Go ahead and apply the Workload.
```terminal:execute
command: kubectl apply -f /home/eduk8s/exercises/workload.yaml
```

###### Track Progress

As a developer, you've just submitted a Workload resource to the cluster.
Makes sense to check the status of that resource!
```terminal:execute
command: kubectl get workload hello-world
```

You can wait a few moments and re-run the above command until the workload is ready. Or, if you're curious to see how the supply chain is progresssing, you can use the Tanzu CLI to track progress along the generated resources

Check the build log file.
```execute-2
tanzu apps workload tail hello-world
```

###### Test App

When the workload is ready, you can test the application.

Check the service.
```execute-1
kn service list
```

Send a request to validate tha the app is responding successfully.
```execute-1
curl http://hello-world-{{ session_namespace }}.{{ ingress_domain }}
```
