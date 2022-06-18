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

```terminal:execute
command: kubectl get workload hello-world -o yaml
```

You can wait a few moments and re-run the above command until the workload is ready.
Or, if you're curious to see how the build is progresssing, you can use the same commands you used in the manual build step to monitor the progress of the build:

Check the status of the build.
```execute-1
kp build list
```

Check the build log file.
```execute-2
kp build logs hello-world
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
