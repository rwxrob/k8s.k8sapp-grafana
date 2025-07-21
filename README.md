# k8s.k8sapp-grafana


## Description

This k8sapp contains Grafana and an enclosed MariaDB instance backing it. An Istio VirtualServer is also provided. A Job with a ServiceAccount to dynamically create a ConfigMap containing the required `grafana.ini` file from a secure ConfigMap template filled with the secrets required by this version of Grafana.

## Prerequisites

Secrets at the followings paths must be create "by hand" in Vault or this k8sapp will not initialize (which is dong by the `config-gen` Job).

```bash
kv/k8s-admin/k8s/CLUSTER/grafana/gh-client-secret
kv/k8s-admin/k8s/CLUSTER/grafana/grafana-admin
kv/k8s-admin/k8s/CLUSTER/grafana/grafana-db-mariadb
kv/k8s-admin/k8s/CLUSTER/grafana/icinga-api-secret
```

TODO add the sample JSON file for the latest version

## Administration

TODO make a note about how to disable AD AutoLogin to access as local administrator.

TODO document the delay of the secrets update Job.

TODO document the backup procedure.

TODO add warning about not cluttering `resources/{grafana,mariadb}/values.yaml`

## Updating

In order to quickly see the difference between versions during regular updates the default values for all Helm charts are saved to their own directory under [`resources`](resources). Simply change the `*CHART_VERSION` to the new one and do a `git diff` to see all changes. See the [`build`](build) script for details.
