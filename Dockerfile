# Build Stage

FROM registry.fedoraproject.org/fedora:latest AS BuildStage

RUN curl -L https://mirror.openshift.com/pub/openshift-v4/x86_64/clients/ocp/latest/openshift-client-linux.tar.gz -o /openshift-client-linux.tar.gz
RUN tar -vxzf /openshift-client-linux.tar.gz -C /

# Deploy Stage

FROM registry.fedoraproject.org/fedora:latest

WORKDIR /
RUN dnf -y install jq

COPY --from=BuildStage /oc /usr/bin/oc
COPY --from=BuildStage /kubectl /usr/bin/kubectl

CMD [ "/main" ]
