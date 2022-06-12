# Getting Applications to Production

The workflow for getting an application to production has many names...

- Continuous Integration and Continuous Delivery/Continuous Deployment
- Pipeline
- DevOps
- DevSecOps
- Supply Chain
- Path to Production

Each term harkens back to particular objectives and priorities that were enabled by different methodologies and technologies over time.
Ultimately, however, the common goal is to streamline the process of moving applications from source code to production while optimizing, at minimum, for reliability, repeatability, and security, and ideally also for usability, maintainability, observability, agility, adaptability, versatility, and speed.

_SAY SOMETHING ABOUT THE CHALLENGES OF TRADITIONAL APPROACHES?_

The evolution of cloud native principles and Kubernetes have enabled a new, elegant, and powerful approach: Supply Chain Choreography on Kubernetes.

In this workshop, you'll learn all about Supply Chain Choreography through hands-on exercises using Cartographer, a Kubernetes-native, open source tool that is easy-to-use and caters to the needs of both developers and operators.

# Agenda

You will start by manually executing a simple path to production on Kubernetes, to understand the basic mechanics of operating a workflow using Kubernetes-native resources and to identify opportunities for automation.

Next, you will introduce Cartographer to choreograph the workflow automatically.
You'll explore both the developer and operator experiences for using Cartographer.

Finally, you'll modify the simple path to production to incorporate a GitOps approach, which enables delivery of the application to any number of target environments.
