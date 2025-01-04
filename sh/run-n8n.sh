#!/bin/bash

# Exit on any error
set -e

echo "Starting n8n installation and setup..."

# Check if Docker is running
if ! docker info >/dev/null 2>&1; then
    echo "Error: Docker is not running or you don't have permission to use Docker."
    echo "Please make sure Docker is running and you have the right permissions."
    exit 1
fi

# Create n8n data volume
echo "Creating n8n data volume..."
sudo docker volume create n8n_data

# Check if port 5678 is already in use
if netstat -tuln | grep -q ":5678 "; then
    echo "Warning: Port 5678 is already in use. Please make sure no other service is using this port."
    exit 1
fi

# Pull the n8n image first
echo "Pulling the latest n8n image..."
sudo docker pull docker.n8n.io/n8nio/n8n

# Run n8n
echo "Starting n8n..."
sudo docker run -it --rm \
    --name n8n \
    -p 5678:5678 \
    -v n8n_data:/home/node/.n8n \
    docker.n8n.io/n8nio/n8n

echo "n8n has been stopped. Your data is preserved in the n8n_data volume."
echo "To start n8n again, just run this script again."
echo "Access n8n at: http://localhost:5678 or http://your-server-ip:5678"