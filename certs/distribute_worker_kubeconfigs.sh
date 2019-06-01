#!/bin/bash

USER="root"
INST_PREFIX="k8s-test-dev-worker-node-pavdmyt-"

for inst_num in 1 2 3; do
  scp kube-proxy.kubeconfig \
    ${INST_PREFIX}${inst_num}.kubeconfig \
    ${USER}@${INST_PREFIX}${inst_num}:~/
done
