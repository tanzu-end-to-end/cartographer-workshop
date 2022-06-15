## Time to Deploy! (Developer Perspective)

#### Apply Workload

Recall the Workload definition you created earlier.

```editor:open-file
file: /home/eduk8s/exercises/workload.yaml
```

Go ahead and apply the Workload.
```terminal:execute
kubectl apply -f /home/eduk8s/exercises/workload.yaml
```

#### Track Progress

As a developer, you've just submitted a Workload resource to the cluster.
Makes sense to check the status of that resource!
```terminal:execute
kubectl get workload hello-world
```

```terminal:execute
kubectl get workload hello-world -o yaml
```

REPEAT FROM MANUAL SECTION?

#### Test App

REPEAT FROM MANUAL SECTION?