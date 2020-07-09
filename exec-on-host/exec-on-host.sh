#!/bin/bash

set -e

function hostexec {
    nsenter -t 1 -a "$@"
}

echo "##### exec-on-host started: $(hostexec hostname) #####"
echo
echo "Pod hostname: $(hostname)"
echo

# exec-on-host ConfigMap is mounted on /exec-on-host
# Host filesystem is mounted on /host
cp /exec-on-host/hello.sh /host/tmp/hello.sh
chmod 755 /host/tmp/hello.sh

hostexec ls -l /tmp/hello.sh
hostexec /tmp/hello.sh
hostexec rm /tmp/hello.sh

# Signal to exec.sh that we're done
echo
echo "##### exec-on-host done: $(hostexec hostname) #####"
sleep infinity

exit 0
