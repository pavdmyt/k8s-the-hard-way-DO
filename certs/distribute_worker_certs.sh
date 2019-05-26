#!/bin/bash

USER="root"
INST_PREFIX="k8s-test-dev-worker-node-pavdmyt-"

for inst_num in 1 2 3; do
  scp ca.pem \
    ${INST_PREFIX}${inst_num}-key.pem \
    ${INST_PREFIX}${inst_num}.pem \
    ${USER}@${INST_PREFIX}${inst_num}:~/
done
