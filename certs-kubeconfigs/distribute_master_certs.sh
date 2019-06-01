#!/bin/bash

USER="root"
INST_PREFIX="k8s-test-dev-master-node-pavdmyt-"

for inst_num in 1 2 3; do
  scp ca.pem \
    ca-key.pem \
    kubernetes-key.pem \
    kubernetes.pem \
    service-account-key.pem \
    service-account.pem \
    ${USER}@${INST_PREFIX}${inst_num}:~/
done
