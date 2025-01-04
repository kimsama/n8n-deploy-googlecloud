# n8n Deployment Guide for Google Cloud

This repository contains scripts and instructions for deploying n8n on Google Cloud Platform using Docker.

## Prerequisites

- Google Cloud Platform account
- Google Cloud VM instance (Ubuntu 24.x LTS)
- SSH access to the VM instance

## Installation Steps

### 1. Install Docker

First, install Docker on your VM instance using the provided script:

```bash
chmod +x sh/install-docker.sh
./sh/install-docker.sh
```

After installation:
1. Log out and log back in to apply Docker group changes:
```bash
exit
```
2. Reconnect to your VM
3. Verify Docker installation:
```bash
docker --version
```

### 2. Install and Run n8n

Install and run n8n using the provided script:

```bash
chmod +x sh/run-n8n.sh
./sh/run-n8n.sh
```

n8n will be available at:
- `http://your-vm-ip:5678`

Your n8n data will be persisted in a Docker volume named `n8n_data`.

## Script Details

### install-docker.sh
- Installs Docker and required dependencies
- Adds the current user to the docker group
- Sets up the Docker repository
- Verifies the installation

### run-n8n.sh
- Creates a Docker volume for n8n data
- Checks for port availability
- Pulls the latest n8n image
- Runs n8n with proper volume mounting
- Provides access information

## Troubleshooting

If you encounter Docker permission issues:
1. Make sure you've logged out and back in after Docker installation
2. Verify Docker service is running:
```bash
sudo systemctl status docker
```
3. Check if your user is in the Docker group:
```bash
groups
```

For port 5678 conflicts:
1. Check if the port is in use:
```bash
netstat -tuln | grep :5678
```
2. Stop any service using port 5678 before running n8n

## Contributing

Feel free to open issues or submit pull requests for improvements.

## License

MIT License