At this point, you should be able to see that by simply leveraging Kubernetes and its rich ecosystem, you can easily establish some of the individual steps that make up a Path to Production.

However, there are some coordination and integration steps that still need to be done manually, specifically:
1. Understand the overall **order and workflow** for a set of steps/resources
2. **Create** instances of Path to Prod resources for each developer application
3. **Monitor** the status of these instances and detect when they have changed
4. **Extract** specific values from the resource statuses
5. **Inject** these values into the next resource in the Path

Next, you'll learn how to automate these steps using Cartographer.

##### Cleanup

Before continuin, go ahead and delete the resources you just created.
```terminal:execute
command: kubectl delete -f /home/eduk8s/exercises/manual/
```