#!/bin/bash
#


for SERVICES in kube-proxy kubelet flanneld docker; do
    systemctl stop $SERVICES
done