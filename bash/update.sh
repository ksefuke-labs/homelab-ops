#!/bin/bash
# safe-reboot.sh - Safely reboot a Talos node
NODE_IP=$1
NODE_NAME=$(kubectl get nodes -o wide | grep $NODE_IP | awk '{print $1}')

# Pre-flight check
#echo "Checking cluster health..."
#talosctl health --nodes $NODE_IP || exit 1

# Cordon and drain
kubectl cordon $NODE_NAME
kubectl drain $NODE_NAME --ignore-daemonsets --delete-emptydir-data --timeout=300s || exit 1

# Reboot
talosctl reboot --nodes $NODE_IP

# Wait and uncordon
echo "Waiting for node to return..."
sleep 60
talosctl health --nodes $NODE_IP --wait-timeout 5m
kubectl uncordon $NODE_NAME

echo "Reboot complete for $NODE_NAME"