### Apply Templates & Supply Chain

#### Templates

Go ahead and apply the three templates you just created to the cluster.

```terminal:execute
command: kubectl apply -f /home/eduk8s/exercises/source.yaml
```

```terminal:execute
command: kubectl apply -f /home/eduk8s/exercises/image.yaml
```

```terminal:execute
command: kubectl apply -f /home/eduk8s/exercises/app-deploy.yaml
```

#### Supply Chain

Next, apply the Supply Chain.

```terminal:execute
command: kubectl apply -f /home/eduk8s/exercises/supply-chain.yaml
```

### Is anything happening?

Not yet!
The ClusterSupplyChain is ready to handle any Workload with a matching label.

In the next step, you'll put on your developer hat and deploy an application using this new Supply Chain.
