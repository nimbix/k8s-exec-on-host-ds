#!/bin/bash

namespace=exec-on-host

kubectl -n $namespace delete daemonset exec-on-host
kubectl -n $namespace delete configmap exec-on-host
kubectl delete namespace $namespace

