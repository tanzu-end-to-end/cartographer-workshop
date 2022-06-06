# Manual Application Deployment

##### The idea

Consider a simple Path to Production consisting of three steps:
1. Download application source code
2. Use the source code to produce a container image
3. Deploy the image and start the application


##### The plan

Now, you could write a script or a fancy little custom program to carry out each of these steps, but if you're going to run your Path to Production on Kubernetes, you don't have to! 

The Kubernetes ecosystem is brimming with exciting projects, and you can find projects that precisely meet your needs.
For this workshop, you'll be working with:
1. FluxCD Source Controller - for downloading source code from git
2. kpack - for building and publishing container images
3. Knative Serving - for running applications

##### Halfway there!
By simply using these tools, you're well on your way to establishing a working Path to Production. Woohoo!

##### However...
There is still a gap to be filled in integrating these tools into a logical workflow and in providing a positive developer experience.
In the next few exercises, you will learn how you can close this gap using Cartographer.

##### But first...
To better understand the workflow and identify the opportunities for automation, start by walking through the process manually.

## Step 1: Download source code

FluxCD Source Controller can poll a git repository periodically and download source code whenever it finds a new commit.

For example, you can use the following configuration to create a GitRepository resource that will poll the sample app repository on GitHub every minute.
```editor:open-file
file: /home/eduk8s/intro/01_manual/source.yaml
```

Apply this configuration to the cluster.
```execute-1
kubectl apply -f /home/eduk8s/intro/01_manual/source.yaml
```

The GitRepository resource should immediately find the latest commit in the git repo and download the code to the cluster.
Verify this by checking the status of the GitRepository resource.
```execute-1
kubectl get gitrepository hello-world -o yaml | yq .status
```

Notice specifically the value of `.status.artifact.url`.
Highlight this value in the terminal and copy it to the clipboard (Ctrl+C or Cmd+C, epending on your computer).
You will need this value in the next step.
```execute-1
kubectl get gitrepository hello-world -o yaml | yq .status.artifact.url
```

## Step 2: Build and publish container image

kpack builds images from source code and publishes the images to an image registry.

You can use the following configuration to create an Image resource that will publish source code from a "blob" (tar file with source code) and publish it to the registry in your workshop session.

```editor:open-file
file: /home/eduk8s/intro/01_manual/image.yaml
```

Notice that the value of the blob is set to a placeholder (`${NEW_SOURCE}`).
```editor:select-matching-text
file: /home/eduk8s/intro/01_manual/image.yaml
text: "${NEW_SOURCE}"
```

Every time the GitRepository downloads new code, the value in the Image registry needs to be updated.
Do the replacement manually by replacing the placeholder with the value you copied in step 1.


Now you can apply the Image resource configuration to the cluster.
```execute-1
kubectl apply -f /home/eduk8s/intro/01_manual/image.yaml
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

Copy this value to your clipboard (highlight it and click either Ctrl+C or Cmd+C).
You will need it in the next step.

## Step 3: Run the application

Knative Serving makes it easy to deploy an application using simple configuration to achieve sophisticated behavior, such as auto-scaling, weighted routing, and managed revisions.

You can use the following configuration to deploy the image created in step 2 using Knative Serving.
```editor:open-file
file: /home/eduk8s/intro/01_manual/app-deploy.yaml
```

Notice the value of the image is set to a placeholder (`${NEW_IMAGE}"`).
```editor:select-matching-text
file: /home/eduk8s/intro/01_manual/app-deploy.yaml
text: "${NEW_IMAGE}"
```

Every time kpack builds a new image, the value in the Knative Serving Service resource needs to be updates.
Do the replacement manually by replacing the placeholder with the value you copied in step 2.

Now you can apply the Service resource configuration to the cluster.
```execute-1
kubectl apply -f /home/eduk8s/intro/01_manual/app-deploy.yaml
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

# Next Steps

At this point, you should be able to see that by simply leveraging Kubernetes and its rich ecosystem, you can easily establish some of the individual steps that make up a Path to Production.

However, there are some coordination and integration steps that still need to be done manually, specifically:
1. Understand the overall order and workflow for a set of steps/resources
2. Create instances of Path to Prod resources for each developer application
3. Monitor the status of these instances and detect when they have changed
4. Extract specific values from the resource statuses
5. Inject these values into the next resource in the Path

Next, you'll learn how to automate these steps using Cartographer.