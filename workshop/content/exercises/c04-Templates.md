## ClusterSupplyChain

So far, you have three templates that can be used to create resources (GitRepository, Image, Service) for any given developer application (Workload).

Is that enough?

- If a developer submits a Workload, how would Cartographer know which resource to create first?
- Let's say you had several more templates, how would Cartographer know to use only these three for this particular workflow?
- How can a developer choose this particular workflow consisting of only these three templates to handle their application?
- Where are the declarations of the variables that you used to specify the dynamic inputs for your ClusterImageTemplate and ClusterTemplate?

All these questions can be answered using a _ClusterSupplyChain_.

#### Supply Chain API

A ClusterSupplyChain enables an application operator to describe a specific workflow, or path to production, as a series of template resources.

Start by creating a new file with the basic structure of a ClusterSupplyChain.

```editor:insert-lines-before-line
file: /home/eduk8s/exercises/supply-chain.yaml
line: 1
text: |-
    apiVersion: carto.run/v1alpha1
    kind: ClusterSupplyChain
    metadata:
      name: supply-chain-{{session_namespace}}
    spec:
      selector:
      resources:
```

#### Resources

You'll need to add three entries to the list of resources—one for each template you created.

Add the ClusterSourceTemplate.

```editor:append-lines-to-file
file: /home/eduk8s/exercises/supply-chain.yaml
text: |-
        # fluxcd/GitRepository
        - name: source-provider
          templateRef:
            kind: ClusterSourceTemplate
            name: source-{{session_namespace}}
```

Add the ClusterImageTemplate.

```editor:append-lines-to-file
file: /home/eduk8s/exercises/supply-chain.yaml
text: |-
        # kpack/Image
        - name: image-builder
          templateRef:
            kind: ClusterImageTemplate
            name: image-{{session_namespace}}
```

Finally, add the ClusterTemplate

```editor:append-lines-to-file
file: /home/eduk8s/exercises/supply-chain.yaml
text: |-
        # kapp-ctrl/App + knative-serving/Service
        - name: deployer
          templateRef:
            kind: ClusterTemplate
            name: app-deploy-{{session_namespace}}
```

Cartographer is now aware of the specific resources to include in this workflow and the order in which these resources must be stamped out.

#### Mapping outputs to inputs

By this point, you know that ClusterSourceTemplate and ClusterImageTemplate produce output values.
As a reminder:
- ClusterSourceTemplate produces the output values `url` and `revision` using the urlPath and revisionPath in the template
- ClusterImageTemplate produces the output value `image` using the imagePath in the template

Recall also that these outputs were injected into the downstream resources as inputs.
- The ClusterSourceTemplate `url` output was injected into the kpack Image configuration as `$(sources.source.url)$`
- The ClusterImageTemplate `image` output was injected into the Knative Serving Service configuration as `$(images.image.image)$`

Where does the syntax for these variables come from?

You guessed it—the ClusterSupplyChain!
The Supply Chain enables you to assign output from one resource as input for another.

Start by assigning the output from the ClusterSourceTemplate, aliased `source-provider` in the CusterSupplyChain, as input to the ClusterImageTemplate, aliased `image-builder`.

Find the `image-builder` resource.
```editor:select-matching-text
file: /home/eduk8s/exercises/supply-chain.yaml
text: "name: image-{{session_namespace}}"
before: 3
after: 0
```

```editor:append-lines-after-match
file: /home/eduk8s/exercises/supply-chain.yaml
match: image-{{session_namespace}}
text: |-
        sources:
          - resource: source-provider
            name: source
```

Notice the path formed by this mapping: `sources.source`.
This explains why, once inside the configuration of the ClusterImageTemplate, you can access the specific values as `$(sources.source.url)$` and `$(sources.source.revision)$`.

Similarly, you need to assign the output from the ClusterImageTemplate as input to the ClusterTemplate, aliased `deployer`.

Find the `deployer` resource.
```editor:select-matching-text
file: /home/eduk8s/exercises/supply-chain.yaml
text: "name: app-deploy-{{session_namespace}}"
before: 3
after: 0
```

```editor:append-lines-after-match
file: /home/eduk8s/exercises/supply-chain.yaml
match: app-deploy-{{session_namespace}}
text: |-
        images:
          - resource: image-builder
            name: image
```

Notice the path formed by this mapping: `images.image`.
This explains why, once inside the configuration of the ClusterTemplate, you can access the specific value `image` output value as `$(images.image.image)$`.

## Workload selector

You're in the home stretch for the Supply Chain configuration.

Imagine you have more than one Supply Chain.
Let's say this one is the one to use for web applications.
You might have another that better suits batch applications, and so on.

You can enable developers to choose the Supply Chain that handles their workload using the Kubernetes concept of labels and selectors.
Developers can place a label (or multiple labels) on their Workloads, and the Supply Chain with selector matching the labels will be used to handle that Workload.

Add a selector to the ClusterSupplyChain.
```editor:append-lines-after-match
file: /home/eduk8s/exercises/supply-chain.yaml
match: "name: supply-chain-{{session_namespace}}"
text: |-
    spec:
      selector:
        app.tanzu.vmware.com/workload-type: web-{{session_namespace}}
```

Go back to the Workload and verify that this is the same value used in the Workload label.
```editor:select-matching-text
file: /home/eduk8s/exercises/workload.yaml
text: app.tanzu.vmware.com/workload-type
before: 0
after: 0
```