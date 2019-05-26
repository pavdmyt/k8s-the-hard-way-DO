#!/bin/bash

# Master nodes
for inst_num in 1 2 3; do
  scp ca.pem \
    ca-key.pem \
    kubernetes-key.pem \
    kubernetes.pem \
    service-account-key.pem \
    service-account.pem \
    root@k8s-test-dev-master-node-pavdmyt-${inst_num}:~/
done
