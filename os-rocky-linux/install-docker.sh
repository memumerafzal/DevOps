#!/bin/bash
# install-docker.sh
# Script to install Docker CE on Rocky Linux

set -e

echo "[1/4] Installing prerequisites..."
sudo dnf -y install dnf-plugins-core

echo "[2/4] Adding Docker repository..."
sudo dnf config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

echo "[3/4] Installing Docker CE..."
sudo dnf install -y docker-ce docker-ce-cli containerd.io

echo "[4/4] Enabling and starting Docker..."
sudo systemctl enable --now docker

echo "✅ Docker installation complete!"
docker run hello-world || echo "Run 'newgrp docker' if permission issues occur."
