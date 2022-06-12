## Step 2: Build and publish container image

kpack builds images from source code and publishes the images to an image registry.

You can use the following configuration to create an Image resource that will publish source code from a "blob" (tar file with source code) and publish it to the registry in your workshop session.

```editor:open-file
file: /home/eduk8s/exercises/intro/01_manual/image.yaml
```

Notice that the value of the blob is set to a placeholder (`${NEW_SOURCE}`).
```editor:select-matching-text
file: /home/eduk8s/exercises/intro/01_manual/image.yaml
text: "${NEW_SOURCE}"
```

Every time the GitRepository downloads new code, the value in the Image registry needs to be updated.
Do the replacement manually by replacing the placeholder with the value you copied in step 1.


Now you can apply the Image resource configuration to the cluster.
```execute-1
kubectl apply -f /home/eduk8s/exercises/intro/01_manual/image.yaml
```

Check the status of the Image resource.
Most likely, you'll see a status indicating the build is in progress.
The build can take a few minutes to complete.
```execute-1
kubectl get imgs hello-world -o yaml | yq .status
```

You can simply wait a minute or so and re-run the command above until the status shows the build has completed.
Alternatively, you can use the following commands to track the progress of the build.

Check the status of the build.
```execute-1
kp build list
```

Check the build log file.
```execute-1
kp build logs hello-world
```

Once the build has finished, you can also check the registry to verify that the image has been published.
```execute-1
skopeo list-tags docker://{{ registry_host }}/hello-world
```

Now that the image is ready, check the status of the Image resource again.
Notice that the tag of the new image is in the field `.status.latestImage`.
```execute-1
kubectl get imgs hello-world -o yaml | yq .status
```

Highlight this value in the terminal and copy it to the clipboard (Ctrl+C or Cmd+C, depending on your computer).
You will need this value in the next step.
```execute-1
kubectl get imgs hello-world -o yaml | yq .status.latestImage
```
