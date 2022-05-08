FROM registry.tanzu.vmware.com/tanzu-application-platform/tap-packages@sha256:a8870aa60b45495d298df5b65c69b3d7972608da4367bd6e69d6e392ac969dd4

#COPY --chown=1001:0 . /home/eduk8s/
#RUN mv /home/eduk8s/workshop /opt/workshop

# All the direct Downloads need to run as root as they are going to /usr/local/bin
USER root
# TBS
RUN curl -L -o /usr/local/bin/kp https://github.com/vmware-tanzu/kpack-cli/releases/download/v0.5.0/kp-linux-0.5.0 && \
  chmod 755 /usr/local/bin/kp

# Tanzu
RUN curl -o /usr/local/bin/tanzu https://storage.googleapis.com/tanzu-cli/artifacts/core/latest/tanzu-core-linux_amd64 && \
  chmod 755 /usr/local/bin/tanzu
COPY plugins/apps-artifacts /tmp/apps-artifacts
COPY plugins/apps-artifacts /tmp/apps-artifacts/
RUN tanzu plugin install apps --local /tmp/apps-artifacts --version v0.5.1
# Knative
RUN curl -L -o /usr/local/bin/kn https://github.com/knative/client/releases/download/knative-v1.4.0/kn-linux-amd64 && \
    chmod 755 /usr/local/bin/kn

USER 1001
RUN fix-permissions /home/eduk8s
