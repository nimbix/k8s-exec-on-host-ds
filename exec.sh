#!/bin/bash

namespace=exec-on-host

function usage {
    cat <<EOF
Usage:
    $0 [options]

Options:
    --namespace <namespace>     K8s namespace to deploy DaemonSet to
EOF
}

while [ $# -gt 0 ]; do
    case $1 in
        --help)
            usage
            exit 0
            ;;
        --namespace)
            namespace=$2
            shift; shift
            ;;
        *)
            usage
            exit 1
            ;;
    esac
done

kubectl create namespace $namespace
kubectl -n $namespace create configmap exec-on-host --from-file exec-on-host
kubectl -n $namespace create -f exec-on-host-ds.yaml

echo
kubectl -n $namespace rollout status daemonset exec-on-host --watch=true
echo

pod_count=$(kubectl -n $namespace get pods 2>/dev/null | grep -c ^exec-on-host-)
pods_done=0
echo -n "Waiting for $pod_count pods to finish executing..."
while [ "$pod_count" -ne "$pods_done" ]; do
    echo -n "."
    sleep 3
    pods_done=$(kubectl -n $namespace logs -l app=exec-on-host --tail=1 | grep -c 'exec-on-host done:')
done
echo

echo "exec-on-host finished on $pod_count nodes..."
echo
echo "View all pod logs with:  kubetail -n $namespace -l app=exec-on-host -s 30m"
echo
echo "Run delete.sh to remove exec-on-host DaemonSet, ConfigMap, and namespace..."
echo

