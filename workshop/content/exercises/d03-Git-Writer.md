#### Implementing git-writer

For the final step of our new supply chain, we want to take the contents of the `ConfigMap` we produced, and write them into a Git repo. But we don't have a good declarative Kubernetes resource for outputting to a Git repo. We will need to run this task as a script, executed imperatively. How do we do that in Cartographer?

We will use a `ClusterTemplate` for this purpose. Let's take a closer look:

```editor:open-file
file: ~/exercises/examples/gitwriter-sc/app-operator/template-git-writer.yaml
```

This `ClusterTemplate` will accept as parameters details about the Git Repo we'll be writing to:

```editor:select-matching-text
file: ~/exercises/examples/gitwriter-sc/app-operator/template-git-writer.yaml
text: "params:"
before: 0
after: 10
```

And it will produce a special Cartographer resource called a `Runnable`.

```editor:select-matching-text
file: ~/exercises/examples/gitwriter-sc/app-operator/template-git-writer.yaml
text: "Runnable"
before: 1
after: 0
```

`Runnable` will serve as a wrapper around the resource that executes the `git push` script, and it will allow us to "decorate" that resource with metadata that Cartographer needs in order to track the status and generate output values.

Further down the same file, we can find the resource we are wrapping:

```editor:select-matching-text
file: ~/exercises/examples/gitwriter-sc/app-operator/template-git-writer.yaml
text: "taskRef:"
before: 0
after: 2
```

Aha! This is a [Tekton](https://tekton.dev/) 'ClusterTask'.

Tekton is general-purpose pipelining tool that can be used to run composable tasks in Kubernetes. We will use it to run a `git push` script.

This is pretty handy, because we now have a mechanism for running arbitrary scripts as part of our supply chain. If you need to add a step to you supply chain and there is no existing ecosystem project that will do the trick, you can use this approach to execute the logic you need in a script.
there is large community support for Tekton tasks, and we now have a method for executing them in our Cartographer supply chains. Let's inspect the task:

```editor:open-file
file: ~/exercises/examples/gitwriter-sc/app-operator/git-writer-task.yaml
```

Here we are. The task uses a base image that has the Git CLI installed, and we can see the script used to write to our Git repo:

```editor:select-matching-text
file: ~/exercises/examples/gitwriter-sc/app-operator/git-writer-task.yaml
text: "bash"
before: 0
after: 21
```

OK, now let's complete our supply chain:

```editor:open-file
file: ~/exercises/supply-chain.yaml
```

We'll add the last step. As input, it will reference the `ConfigMap` that was generated in the previous step. It will then execute the Tekton task to write out the `ConfigMap` data to our Git repo:

```editor:append-lines-to-file
file: /home/eduk8s/exercises/supply-chain.yaml
text: |2
      # Tekton/TaskRun
      - name: git-writer
        templateRef:
          kind: ClusterTemplate
          name:  osscon-git-writer
        configs:
          - resource: config-provider
            name: data
```
