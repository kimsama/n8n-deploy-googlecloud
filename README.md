# n8n Deployment Guide for Google Cloud

This repository contains scripts and instructions for deploying n8n on Google Cloud Platform using Docker.

## Prerequisites

- Google Cloud Platform account
- Google Cloud VM instance (Ubuntu 24.x LTS)
- SSH access to the VM instance

## Installation Steps

### 1. Install Docker

First, install Docker on your VM instance using the provided script ([install-docker.sh](sh/install-docker.sh)):

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

You have two options to run n8n:

#### Option 1: Standard Setup
Install and run n8n using the standard script ([run-n8n.sh](sh/run-n8n.sh)):

```bash
chmod +x sh/run-n8n.sh
./sh/run-n8n.sh
```

#### Option 2: Setup with Insecure Cookies
If you need to run n8n with insecure cookies (e.g., for development or testing), use this script ([run-n8n-insecure.sh](sh/run-n8n-insecure.sh)):

```bash
chmod +x sh/run-n8n-insecure.sh
./sh/run-n8n-insecure.sh
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

### run-n8n-insecure.sh
- Similar to run-n8n.sh but runs n8n with insecure cookies
- Useful for development or testing environments
- Not recommended for production use

## Additional Operations

### Container Management

#### Checking Container Status
To check if n8n is currently running:
```bash
# List all running containers
docker ps

# Or specifically filter for n8n
docker ps | grep n8n
```

To see all containers (including stopped ones):
```bash
docker ps -a | grep n8n
```

#### Stopping Container
To stop the running n8n container:
```bash
docker stop n8n
```

#### Viewing Container Logs
To view the logs of the n8n container:
```bash
# View logs
docker logs n8n

# Follow logs in real-time
docker logs -f n8n

# View last 100 lines
docker logs --tail 100 n8n
```

### Rerunning n8n
After stopping n8n with `Ctrl+C`, you can restart it with the following command (note the added -d flag for detached mode):

```bash
sudo docker run -it --rm --name n8n -p 5678:5678 -e WEBHOOK_URL="https://???" -v n8n_data:/home/node/.n8n -d docker.n8n.io/n8nio/n8n
```

### Updating n8n to the Latest Version
To update n8n to the latest version:
1. Stop the current instance with `Ctrl+C`
2. Run the following command which includes the --pull="always" flag to ensure the latest image is used:

```bash
sudo docker run -it --rm --name n8n -p 5678:5678 -e WEBHOOK_URL="https://???" -v n8n_data:/home/node/.n8n -d --pull="always" docker.n8n.io/n8nio/n8n
```

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

### References
- [n8n Installation on Google Cloud Platform Guide](https://www.youtube.com/watch?v=kdt5J2bpchM&t=6s)
- [Hosting on Render.com](https://www.youtube.com/watch?v=7G9KX2uA8H8)

## License

MIT License