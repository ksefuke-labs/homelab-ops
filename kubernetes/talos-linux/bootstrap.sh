#!/usr/bin/env bash
set -euo pipefail

: "${GITHUB_TOKEN:?Set GITHUB_TOKEN (fine-grained PAT with read access to the repo)}"
AGE_KEY_FILE="${AGE_KEY_FILE:-$HOME/.sops/age.agekey}"
[[ -f "$AGE_KEY_FILE" ]] || { echo "age key not found: $AGE_KEY_FILE" >&2; exit 1; }

GATEWAY_API_VERSION="v1.6.3"
CILIUM_VERSION="1.20.3"
REPO_URL="https://github.com/ksefuke-labs/homelab-ops"
SYNC_PATH="kubernetes/clusters/staging"
CILIUM_VALUES_URL="https://raw.githubusercontent.com/ksefuke-labs/homelab-ops/main/kubernetes/infrastructure/controllers/base/cilium/values.yaml"

## 2. Cilium (nodes stay NotReady until this is up)
helm repo add cilium https://helm.cilium.io/ --force-update
helm upgrade --install cilium cilium/cilium \
  --version "${CILIUM_VERSION}" -n kube-system \
  -f "${CILIUM_VALUES_URL}"

kubectl -n kube-system rollout status ds/cilium --timeout=300s
kubectl -n kube-system rollout status deploy/cilium-operator --timeout=300s
kubectl wait --for=condition=Ready nodes --all --timeout=300s

## 3. Flux namespace + secrets
kubectl create namespace flux-system --dry-run=client -o yaml | kubectl apply -f -

kubectl -n flux-system create secret generic sops-age \
  --from-file=age.agekey="${AGE_KEY_FILE}" \
  --dry-run=client -o yaml | kubectl apply -f -

kubectl -n flux-system create secret generic flux-system \
  --from-literal=username=git \
  --from-literal=password="${GITHUB_TOKEN}" \
  --dry-run=client -o yaml | kubectl apply -f -

flux check --pre

flux bootstrap github \
  --token-auth \
  --owner=ksefuke-labs \
  --repository=homelab-ops \
  --branch=main \
  --path=./kubernetes/clusters/staging \
  --personal

flux check
