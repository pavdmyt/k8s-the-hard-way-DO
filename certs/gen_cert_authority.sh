#!/bin/bash

cat > ca-config.json <<EOF
{
  "signing": {
    "default": {
      "expiry": "8760h"
    },
    "profiles": {
      "kubernetes": {
        "usages": ["signing", "key encipherment", "server auth", "client auth"],
        "expiry": "8760h"
      }
    }
  }
}
EOF

cat > ca-csr.json <<EOF
{
  "CN": "Kubernetes",
  "key": {
    "algo": "rsa",
    "size": 2048
  },
  "names": [
    {
      "C": "UA",
      "L": "Kyiv",
      "O": "Kubernetes",
      "OU": "CA",
      "ST": "Kyivska Oblast"
    }
  ]
}
EOF

cfssl gencert -initca ca-csr.json | cfssljson -bare ca
