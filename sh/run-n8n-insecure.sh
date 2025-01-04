#!/bin/bash

# Exit on any error
set -e

echo "Starting n8n with insecure cookies in detached mode..."

# Check if Docker is running
if ! docker info >/dev/null 2>&1; then
    echo "Error: Docker is not running or you don't have permission to use Docker."
    echo "Please make sure Docker is running and you have the right permissions."
    exit 1
fi

# Check if port 5678 is already in use
if netstat -tuln | grep -q ":5678 "; then
    echo "Warning: Port 5678 is already in use. Please make sure no other service is using this port."
    exit 1
fi

# Run n8n with insecure cookies in detached mode
echo "Running n8n..."
sudo docker run -it --rm \
    --name n8n \
    -p 5678:5678 \
    -v n8n_data:/home/node/.n8n \
    -e N8N_SECURE_COOKIE=false \
    -d \
    docker.n8n.io/n8nio/n8n

echo "n8n has been started in detached mode. Your data is preserved in the n8n_data volume."
echo "The container will continue running in the background."
echo "Access n8n at: http://localhost:5678 or http://your-server-ip:5678"
echo ""
echo "To check the container status, use: docker ps | grep n8n"
echo "To stop the container, use: docker stop n8n"
echo "To view container logs, use: docker logs n8n"