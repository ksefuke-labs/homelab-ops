#!/bin/bash
kubectl create namespace flux-system

helm repo add cilium https://helm.cilium.io/
helm repo update
helm install cilium cilium/cilium --version 1.18.0 -n kube-system -f https://raw.githubusercontent.com/ksefuke-labs/homelab-ops/main/kubernetes/infrastructure/controllers/base/cilium/values.yaml

cat $HOME/.sops/age.agekey | kubectl create secret generic sops-age --namespace=flux-system --from-file=age.agekey=/dev/stdin

flux bootstrap github \
  --token-auth \
  --owner=ksefuke-labs \
  --repository=homelab-ops \
  --branch=main \
  --path=./kubernetes/clusters/staging \
  --personal