#!/bin/bash

USER="root"
INST_PREFIX="k8s-test-dev-master-node-pavdmyt-"

for inst_num in 1 2 3; do
  scp admin.kubeconfig \
    kube-controller-manager.kubeconfig \
    kube-scheduler.kubeconfig \
    ${USER}@${INST_PREFIX}${inst_num}:~/
done
