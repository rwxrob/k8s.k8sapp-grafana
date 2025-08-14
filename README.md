# k8s.k8sapp-grafana

## Description

This k8sapp contains Grafana derived from the bitnama/grafana Helm chart. An Istio VirtualServer is also provided.

## Prerequisites

Get the version using the following command:

```sh
helm search repo grafana/grafana --versions | awk '$1 == "grafana/grafana"'
```

Secrets at the followings paths must be create "by hand" in Vault or this k8sapp will not initialize (which is dong by the `config-gen` Job).

```bash
kv/k8s-admin/k8s/CLUSTER/grafana/gh-client-secret
kv/k8s-admin/k8s/CLUSTER/grafana/grafana-admin
```

TODO add the sample JSON file for the latest version

## Administration

TODO make a note about how to disable AD AutoLogin to access as local administrator.

TODO document the delay of the secrets update Job.

TODO document the backup procedure.

TODO add warning about not cluttering `resources/grafana/values.yaml`

TODO for testing locally (cluster: `minikube`)

```sh
kubectl port-forward -n grafana svc/grafana 3008:80
```

TODO document how to change the password (not by changing the secret, have to use the command line)

## Updating

In order to quickly see the difference between versions during regular updates the default values for all Helm charts are saved to their own directory under [`resources`](resources). Simply change the `*CHART_VERSION` to the new one and do a `git diff` to see all changes. See the [`build`](build) script for details.
