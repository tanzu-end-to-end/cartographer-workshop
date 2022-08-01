#### Running the Updated Supply Chain

The templates you just reviewed are already deployed to the cluster.
You can verify this using the following commands.

```terminal:execute
command: kubectl get clusterconfigtemplate osscon-app-config
```

```terminal:execute
command: kubectl get clustertemplate osscon-git-writer 
```

Let's go ahead and apply the definition for our updated supply chain.

```terminal:execute
command: kubectl apply -f ~/exercises/supply-chain.yaml
```

Remember, this is the behavior we are implementing in our new definition:
![Cartographer GitOps](images/cartographer-gitops.png)

Now, we can revisit our workload:

```editor:open-file
file: /home/eduk8s/exercises/workload.yaml
```

We will update our workload, providing a GitRepository parameter that lets the supply chain know where the target GitOps repo is located.

```editor:append-lines-to-file
file: /home/eduk8s/exercises/workload.yaml
text: |2
    params:
      - name: git_repository
        value: https://{{ENV_GITEA_USER}}:{{ENV_GITEA_PASSWORD}}@gitea.{{ingress_domain}}/gitea_admin/{{session_namespace}}.git
```

Re-creating our workload will cause our application to be delivered using the new supply chain:

```terminal:execute
command: kubectl apply -f ~/exercises/workload.yaml
```

We can follow along as the supply chain progresses:
```execute-2
tanzu apps workload tail hello-world
```

You can use the following command to verify that the workload is ready.
```terminal:execute
command: kubectl get workload hello-world
```

When the workload status says `Ready`, we can see there is no Knative Service running

```terminal:execute
command: kubectl get ksvc
```

Instead of creating a deployment, we have written a description of the deployment to our Git repo. Inspect the contents of the `manifest.yaml` file that was written out to Git.

```dashboard:open-url
url: https://gitea.{{ingress_domain}}/gitea_admin/{{session_namespace}}/src/branch/main/config
```

OK, now for the final step: using GitOps to run our application on target clusters.