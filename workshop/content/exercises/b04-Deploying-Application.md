#### Step 3: Run the application

Knative Serving makes it easy to deploy an application using simple configuration to achieve sophisticated behavior, such as auto-scaling, weighted routing, and managed revisions.

You can use the following configuration to deploy the image created in step 2 using Knative Serving.
```editor:open-file
file: /home/eduk8s/exercises/manual/app-deploy.yaml
```

Notice the value of the image is set to a placeholder (`${NEW_IMAGE}"`).
```editor:select-matching-text
file: /home/eduk8s/exercises/manual/app-deploy.yaml
text: "${NEW_IMAGE}"
```

Every time kpack builds a new image, the value in the Knative Serving Service resource needs to be updates.
Do the replacement manually by replacing the placeholder with the value you copied in step 2.

Now you can apply the Service resource configuration to the cluster.
```execute-1
kubectl apply -f /home/eduk8s/exercises/manual/app-deploy.yaml
```

Check the service.
```execute-1
kn service list
```

The app is deployed and running.
Send a request to validate that everything is working.
```execute-1
curl http://hello-world-{{ session_namespace }}.{{ ingress_domain }}
```
