##### Time to Deploy! (Developer Perspective)

###### Apply Workload

Recall the Workload definition you created earlier now we are just going to using the same one, just point it to a different project. A springboot application in this example.

```editor:open-file
file: /home/eduk8s/exercises/spring-workload.yaml
```

Go ahead and apply the Workload.
```terminal:execute
command: kubectl apply -f /home/eduk8s/exercises/spring-workload.yaml
```

###### Track Progress

As a developer, you've just submitted a Workload resource to the cluster.
Makes sense to check the status of that resource!
```terminal:execute
command: kubectl get workload spring
```

You can wait a few moments and re-run the above command until the workload is ready. Or, if you're curious to see how the supply chain is progresssing, you can use the Tanzu CLI to track progress along the generated resources

Check the build log file.
```execute-2
tanzu apps workload tail spring
```

Once you see the message "Build successful" from the workload pods, you can send a Control-C to the bottom terminal window to end the tail.

```execute-2
<ctrl+c>
```

###### Test App

When the workload is ready, you can test the application.

Check the service.
```execute-1
kn service list
```

Send a request to validate tha the app is responding successfully.
```execute-1
curl http://spring-{{ session_namespace }}.{{ ingress_domain }}
```
