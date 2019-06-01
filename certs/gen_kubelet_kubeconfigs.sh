#!/bin/bash

KUBERNETES_PUBLIC_ADDRESS=${LB_IP:-""}
if [ -z $KUBERNETES_PUBLIC_ADDRESS ]; then
  echo "Error: KUBERNETES_PUBLIC_ADDRESS is not set"
  exit 1
fi

INST_PREFIX="k8s-test-dev-worker-node-pavdmyt-"

for inst_num in 1 2 3; do
  kubectl config set-cluster kubernetes-the-hard-way \
    --certificate-authority=ca.pem \
    --embed-certs=true \
    --server=https://${KUBERNETES_PUBLIC_ADDRESS}:6443 \
    --kubeconfig=${INST_PREFIX}${inst_num}.kubeconfig

  kubectl config set-credentials system:node:${INST_PREFIX}${inst_num} \
    --client-certificate=${INST_PREFIX}${inst_num}.pem \
    --client-key=${INST_PREFIX}${inst_num}-key.pem \
    --embed-certs=true \
    --kubeconfig=${INST_PREFIX}${inst_num}.kubeconfig

  kubectl config set-context default \
    --cluster=kubernetes-the-hard-way \
    --user=system:node:${INST_PREFIX}${inst_num} \
    --kubeconfig=${INST_PREFIX}${inst_num}.kubeconfig

  kubectl config use-context default --kubeconfig=${INST_PREFIX}${inst_num}.kubeconfig
done
