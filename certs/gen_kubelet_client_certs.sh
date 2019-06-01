#!/bin/bash

USER="root"
INST_PREFIX="k8s-test-dev-worker-node-pavdmyt-"

for inst_num in 1 2 3; do

cat > ${INST_PREFIX}${inst_num}-csr.json <<EOF
{
  "CN": "system:node:${INST_PREFIX}${inst_num}",
  "key": {
    "algo": "rsa",
    "size": 2048
  },
  "names": [
    {
      "C": "UA",
      "L": "Kyiv",
      "O": "system:nodes",
      "OU": "Kubernetes The Hard Way",
      "ST": "Kyivska Oblast"
    }
  ]
}
EOF

# Cleanup
ssh-keygen -R ${INST_PREFIX}${inst_num}

EXTERNAL_IP=$(ssh ${USER}@${INST_PREFIX}${inst_num} hostname -I \
  | cut -d " " -f1)

INTERNAL_IP=$(ssh ${USER}@${INST_PREFIX}${inst_num} hostname -I \
  | cut -d " " -f3)

cfssl gencert \
  -ca=ca.pem \
  -ca-key=ca-key.pem \
  -config=ca-config.json \
  -hostname=${INST_PREFIX}${inst_num},${EXTERNAL_IP},${INTERNAL_IP} \
  -profile=kubernetes \
  ${INST_PREFIX}${inst_num}-csr.json \
  | cfssljson -bare ${INST_PREFIX}${inst_num}

done
