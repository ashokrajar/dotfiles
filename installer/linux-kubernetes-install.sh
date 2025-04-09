#!/bin/bash

# Update packages and install required dependencies
sudo apt-get update && sudo apt-get upgrade -y
sudo apt-get install -y apt-transport-https ca-certificates curl

# Add Kubernetes GPG key and repository
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.32/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.32/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list

# Install Kubernetes components
sudo apt-get install -y kubernetes-cni kubelet kubectl kubeadm cri-tools
sudo apt-mark hold kubernetes-cni kubelet kubectl kubeadm kubectl cri-tools

# Disable swap as required by Kubernetes
sudo swapoff -a
sudo sed -i '/ swap / s/^/#/' /etc/fstab

# Enable and load kernel modules
sudo modprobe overlay
sudo modprobe br_netfilter

# Apply sysctl settings for Kubernetes networking
cat <<EOF | sudo tee /etc/sysctl.d/kubernetes.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
net.ipv4.ip_forward = 1
EOF
sudo sysctl --system

# Install container runtime (containerd)
dockerd-rootless-setuptool.sh uninstall

sudo apt-get update && sudo apt-get install -y containerd
sudo mkdir -p /etc/containerd
containerd config default | sudo tee /etc/containerd/config.toml
sudo systemctl restart containerd
sudo systemctl enable containerd
