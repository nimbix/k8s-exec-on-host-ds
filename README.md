# k8s-exec-on-host-ds
DaemonSet to execute arbitrary commands on kubernetes host nodes

**There are obvious security implications to using this DaemonSet.  Please be
sure that you know what you are doing before deploying it.**

## Prerequisite-ish

While not strictly required, installing
[kubetail](https://github.com/johanhaleby/kubetail) will be helpful when
reviewing the pod logs.

## Usage

### `exec-on-host-ds.yaml`

Edit `exec-on-host-ds.yaml` to adjust the `nodeSelector` and `tolerations`
so that the DaemonSet pods will run on the desired hosts.

### Update/add scripts/files in `exec-on-host` directory

The files in `exec-on-host` directory will be used to create the
`exec-on-host` ConfigMap used by the DaemonSet.
The DaemonSet pods will run `exec-on-host.sh` by default.  Update that
script as desired to do work on the hosts which the DaemonSet pods run on.
 
### `exec.sh`

The `exec.sh` script will create the `exec-on-host` namespace, ConfigMap,
and DaemonSet in your cluster.

### `delete.sh`

The `delete.sh` script will remove the namespace, ConfigMap,
and DaemonSet from your cluster.

