#!/bin/bash

namespace=exec-on-host
deletens=

function usage {
    cat <<EOF
Usage:
    $0 [options]

Options:
    --namespace <namespace>     K8s namespace to remove DaemonSet from
    --delete-namespace          Delete namespace after deleting the DaemonSet
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
        --delete-namespace)
            deletens=y
            shift;
            ;;
        *)
            usage
            exit 1
            ;;
    esac
done

kubectl -n $namespace delete daemonset exec-on-host
kubectl -n $namespace delete configmap exec-on-host
[ -n "$deletens" ] && kubectl delete namespace $namespace

