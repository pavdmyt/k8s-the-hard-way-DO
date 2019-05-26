#!/bin/bash

# Worker nodes
for inst_num in 1 2 3; do
  scp ca.pem \
    k8s-test-dev-worker-node-pavdmyt-${inst_num}-key.pem \
    k8s-test-dev-worker-node-pavdmyt-${inst_num}.pem \
    root@k8s-test-dev-worker-node-pavdmyt-${inst_num}:~/
done
