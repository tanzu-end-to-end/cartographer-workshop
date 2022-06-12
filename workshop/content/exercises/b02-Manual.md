## Step 1: Download source code

FluxCD Source Controller can poll a git repository periodically and download source code whenever it finds a new commit.

For example, you can use the following configuration to create a GitRepository resource that will poll the sample app repository on GitHub every minute.
```editor:open-file
file: /home/eduk8s/exercises/intro/01_manual/source.yaml
```

Apply this configuration to the cluster.
```execute-1
kubectl apply -f /home/eduk8s/exercises/intro/01_manual/source.yaml
```

The GitRepository resource should immediately find the latest commit in the git repo and download the code to the cluster.
Verify this by checking the status of the GitRepository resource.
```execute-1
kubectl get gitrepository hello-world -o yaml | yq .status
```

Notice specifically the value of `.status.artifact.url`.
Highlight this value in the terminal and copy it to the clipboard (Ctrl+C or Cmd+C, depending on your computer).
You will need this value in the next step.
```execute-1
kubectl get gitrepository hello-world -o yaml | yq .status.artifact.url
```
