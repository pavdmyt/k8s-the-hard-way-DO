#!/bin/bash

KUBERNETES_PUBLIC_ADDRESS=${LB_IP:-""}
if [ -z $KUBERNETES_PUBLIC_ADDRESS ]; then
  echo "Error: KUBERNETES_PUBLIC_ADDRESS is not set"
  exit 1
fi

INST_PREFIX="k8s-test-dev-master-node-pavdmyt-"
# Cleanup
ssh-keygen -R ${INST_PREFIX}1
ssh-keygen -R ${INST_PREFIX}2
ssh-keygen -R ${INST_PREFIX}3

USER="root"
INTERNAL_IP_MASTER1=$(ssh ${USER}@${INST_PREFIX}1 hostname -I | cut -d " " -f3)
INTERNAL_IP_MASTER2=$(ssh ${USER}@${INST_PREFIX}2 hostname -I | cut -d " " -f3)
INTERNAL_IP_MASTER3=$(ssh ${USER}@${INST_PREFIX}3 hostname -I | cut -d " " -f3)

cat > kubernetes-csr.json <<EOF
{
  "CN": "kubernetes",
  "key": {
    "algo": "rsa",
    "size": 2048
  },
  "names": [
    {
      "C": "UA",
      "L": "Kyiv",
      "O": "Kubernetes",
      "OU": "Kubernetes The Hard Way",
      "ST": "Kyivska Oblast"
    }
  ]
}
EOF

cfssl gencert \
  -ca=ca.pem \
  -ca-key=ca-key.pem \
  -config=ca-config.json \
  -hostname=10.32.0.1,${INTERNAL_IP_MASTER1},${INTERNAL_IP_MASTER2},${INTERNAL_IP_MASTER3},${KUBERNETES_PUBLIC_ADDRESS},127.0.0.1,kubernetes.default \
  -profile=kubernetes \
  kubernetes-csr.json | cfssljson -bare kubernetes
