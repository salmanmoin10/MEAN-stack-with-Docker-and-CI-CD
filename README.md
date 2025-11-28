# MEAN Stack CRUD Application - DevOps Deployment

A full-stack CRUD application using the MEAN stack (MongoDB, Express, Angular 15, and Node.js) with complete Docker containerization and CI/CD pipeline.

## 📋 Table of Contents

- [Overview](#overview)
- [Architecture](#architecture)
- [Prerequisites](#prerequisites)
- [Local Development Setup](#local-development-setup)
- [Docker Setup](#docker-setup)
- [Cloud Deployment](#cloud-deployment)
- [CI/CD Pipeline](#cicd-pipeline)
- [Project Structure](#project-structure)
- [Screenshots](#screenshots)

## 🎯 Overview

This application manages a collection of tutorials where each tutorial includes an ID, title, description, and published status. Users can:

- Create new tutorials
- Retrieve all tutorials or search by title
- Update existing tutorials
- Delete tutorials individually or all at once

The backend is developed with Node.js and Express, providing REST APIs connected to a MongoDB database. The frontend is an Angular 15 application that communicates with the backend via HTTP requests.

## 🏗️ Architecture

```
┌─────────────┐
│   Client    │
│  (Browser)  │
└──────┬──────┘
       │ HTTP (Port 80)
       ▼
┌─────────────────────┐
│  Nginx Reverse Proxy│
│    (Port 80)        │
└──────┬──────────────┘
       │
       ├─────► Frontend (Angular) → Port 4200
       │
       └─────► Backend (Node.js)  → Port 8080
                      │
                      ▼
               ┌─────────────┐
               │  MongoDB    │
               │ (Port 27017)│
               └─────────────┘
```

## ✅ Prerequisites

### For Local Development:

- Node.js (v16 or higher)
- Angular CLI (v15)
- MongoDB (v6.0 or higher)

### For Docker Deployment:

- Docker (v20.10 or higher)
- Docker Compose (v2.0 or higher)
- Docker Hub account

### For Cloud Deployment:

- Ubuntu VM on AWS/Azure/GCP
- GitHub account
- SSH access to the VM

## 🚀 Local Development Setup

### Backend Setup

```bash
cd backend
npm install
```

Configure MongoDB connection in `backend/app/config/db.config.js`:

```javascript
module.exports = {
  url: process.env.MONGODB_URI || "mongodb://localhost:27017/dd_db",
};
```

Start the backend server:

```bash
node server.js
```

Server will run on `http://localhost:8080`

### Frontend Setup

```bash
cd frontend
npm install
```

The frontend is configured to communicate with the backend API. For local development, it uses `http://localhost:8080/api`.

Start the frontend:

```bash
ng serve --port 8081
```

Application will be available at `http://localhost:8081`

## 🐳 Docker Setup

### 1. Build Docker Images Locally

First, set your Docker Hub username in `.env` file:

```bash
# Copy the example file
cp .env.example .env

# Edit .env and set your Docker Hub username
DOCKER_USERNAME=your_dockerhub_username
```

Build the images:

```bash
# Build backend
docker build -t your_dockerhub_username/mean-backend:latest ./backend

# Build frontend
docker build -t your_dockerhub_username/mean-frontend:latest ./frontend
```

### 2. Push to Docker Hub

Login to Docker Hub:

```bash
docker login
```

Push the images:

```bash
docker push your_dockerhub_username/mean-backend:latest
docker push your_dockerhub_username/mean-frontend:latest
```

### 3. Run with Docker Compose

Start all services:

```bash
docker-compose up -d
```

The application will be available at:

- Main application: `http://localhost`
- Backend API: `http://localhost/api`
- Direct backend: `http://localhost:8080` (for testing)

Check the status:

```bash
docker-compose ps
docker-compose logs -f
```

Stop all services:

```bash
docker-compose down
```

## ☁️ Cloud Deployment

### 1. Set Up Ubuntu VM

Create an Ubuntu VM on your preferred cloud provider (AWS, Azure, GCP). Ensure the following ports are open:

- Port 80 (HTTP)
- Port 22 (SSH)

### 2. Install Docker and Docker Compose

SSH into your VM and run:

```bash
# Update system
sudo apt update && sudo apt upgrade -y

# Install Docker
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo usermod -aG docker $USER

# Install Docker Compose
sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Verify installation
docker --version
docker-compose --version

# Log out and log back in for group changes to take effect
```

### 3. Deploy Application

Create a directory for the application:

```bash
mkdir -p ~/mean-app
cd ~/mean-app
```

Copy the necessary files to the VM:

- `docker-compose.yml`
- `nginx/nginx.conf`
- `deploy.sh`
- `.env`

Or clone from your GitHub repository:

```bash
git clone https://github.com/yourusername/your-repo.git
cd your-repo
```

Create `.env` file:

```bash
echo "DOCKER_USERNAME=your_dockerhub_username" > .env
```

Make the deploy script executable and run it:

```bash
chmod +x deploy.sh
./deploy.sh
```

### 4. Verify Deployment

Check if all containers are running:

```bash
docker ps
```

Access your application:

- From browser: `http://your-vm-ip`

## 🔄 CI/CD Pipeline

### GitHub Actions Setup

The project includes a GitHub Actions workflow that:

1. Builds Docker images when code is pushed to main/master
2. Pushes images to Docker Hub
3. Deploys to the Ubuntu VM automatically

### Configure GitHub Secrets

Add the following secrets to your GitHub repository (Settings → Secrets and variables → Actions):

| Secret Name       | Description                    | Example                              |
| ----------------- | ------------------------------ | ------------------------------------ |
| `DOCKER_USERNAME` | Your Docker Hub username       | `johndoe`                            |
| `DOCKER_PASSWORD` | Your Docker Hub password/token | `dckr_pat_xxxxx`                     |
| `SERVER_HOST`     | Your VM's IP address           | `54.123.45.67`                       |
| `SERVER_USER`     | SSH username for your VM       | `ubuntu`                             |
| `SSH_PRIVATE_KEY` | Private SSH key for VM access  | `-----BEGIN RSA PRIVATE KEY-----...` |

### Generate SSH Key for CI/CD

On your local machine:

```bash
# Generate SSH key pair
ssh-keygen -t rsa -b 4096 -f ~/.ssh/mean-deploy -N ""

# Copy public key to your VM
ssh-copy-id -i ~/.ssh/mean-deploy.pub user@your-vm-ip

# Display private key (copy this to GitHub secret)
cat ~/.ssh/mean-deploy
```

### Trigger Deployment

Push code to trigger the pipeline:

```bash
git add .
git commit -m "Deploy application"
git push origin main
```

The GitHub Actions workflow will:

1. Checkout the code
2. Build Docker images for frontend and backend
3. Push images to Docker Hub
4. SSH into your VM
5. Pull latest images
6. Restart containers using the deploy script

### Monitor Pipeline

View the pipeline execution:

- Go to your GitHub repository
- Click on "Actions" tab
- Select the latest workflow run

## 📁 Project Structure

```
crud-dd-task-mean-app/
├── .github/
│   └── workflows/
│       └── deploy.yml          # GitHub Actions CI/CD pipeline
├── backend/
│   ├── app/
│   │   ├── config/
│   │   │   └── db.config.js    # MongoDB configuration
│   │   ├── controllers/
│   │   │   └── tutorial.controller.js
│   │   ├── models/
│   │   │   ├── index.js
│   │   │   └── tutorial.model.js
│   │   └── routes/
│   │       └── turorial.routes.js
│   ├── .dockerignore
│   ├── Dockerfile              # Backend Docker image
│   ├── package.json
│   └── server.js
├── frontend/
│   ├── src/
│   │   ├── app/
│   │   │   ├── components/
│   │   │   │   ├── add-tutorial/
│   │   │   │   ├── tutorial-details/
│   │   │   │   └── tutorials-list/
│   │   │   ├── models/
│   │   │   │   └── tutorial.model.ts
│   │   │   ├── services/
│   │   │   │   └── tutorial.service.ts
│   │   │   └── app.module.ts
│   │   ├── environments/
│   │   │   ├── environment.ts
│   │   │   └── environment.prod.ts
│   │   └── index.html
│   ├── .dockerignore
│   ├── Dockerfile              # Frontend Docker image
│   ├── nginx.conf              # Nginx config for frontend
│   ├── angular.json
│   └── package.json
├── nginx/
│   └── nginx.conf              # Nginx reverse proxy config
├── .env.example                # Environment variables template
├── docker-compose.yml          # Docker Compose configuration
├── deploy.sh                   # Deployment script
└── README.md                   # This file
```

## 🛠️ Key Configuration Files

### Backend Dockerfile

The backend uses a Node.js Alpine image for a lightweight container:

```dockerfile
FROM node:16-alpine
WORKDIR /app
COPY package*.json ./
RUN npm install --production
COPY . .
EXPOSE 8080
CMD ["node", "server.js"]
```

### Frontend Dockerfile

The frontend uses multi-stage build for optimized production image:

```dockerfile
# Stage 1: Build
FROM node:16-alpine AS build
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# Stage 2: Serve with Nginx
FROM nginx:alpine
COPY --from=build /app/dist/angular-15-crud /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
```

### Docker Compose Services

The `docker-compose.yml` defines four services:

- **MongoDB**: Database service with persistent volume
- **Backend**: Node.js API server
- **Frontend**: Angular application served by Nginx
- **Nginx**: Reverse proxy routing requests

### Nginx Reverse Proxy Configuration

The reverse proxy routes requests:

- `/` → Frontend container (port 80)
- `/api/` → Backend container (port 8080)

## 📸 Screenshots

### CI/CD Pipeline Configuration

![GitHub Actions Workflow](.screenshots/github-actions.png)
_GitHub Actions workflow configuration_

![Pipeline Execution](.screenshots/pipeline-execution.png)
_Successful CI/CD pipeline execution_

### Docker Build and Push

![Docker Build](.screenshots/docker-build.png)
_Building Docker images locally_

![Docker Hub](.screenshots/docker-hub.png)
_Docker images pushed to Docker Hub_

### Application Deployment

![Application Running](.screenshots/app-running.png)
_Application UI running successfully_

![Tutorial List](.screenshots/tutorial-list.png)
_Tutorials list view_

![Add Tutorial](.screenshots/add-tutorial.png)
_Add tutorial form_

### Infrastructure

![VM Setup](.screenshots/vm-setup.png)
_Ubuntu VM configuration on cloud platform_

![Docker Containers](.screenshots/docker-containers.png)
_Running Docker containers on VM_

![Nginx Configuration](.screenshots/nginx-config.png)
_Nginx reverse proxy setup_

## 🔧 Troubleshooting

### Container Issues

If containers fail to start:

```bash
# Check logs
docker-compose logs backend
docker-compose logs frontend
docker-compose logs mongodb

# Restart specific service
docker-compose restart backend

# Rebuild images
docker-compose up -d --build
```

### Database Connection Issues

If backend can't connect to MongoDB:

```bash
# Check MongoDB is running
docker-compose ps mongodb

# Check MongoDB logs
docker-compose logs mongodb

# Test MongoDB connection
docker exec -it mean-mongodb mongosh --eval "db.adminCommand('ping')"
```

### Network Issues

If services can't communicate:

```bash
# Inspect network
docker network ls
docker network inspect crud-dd-task-mean-app_mean-network

# Verify DNS resolution
docker exec mean-backend ping mongodb
```

### Port Conflicts

If ports are already in use:

```bash
# Check what's using port 80
sudo lsof -i :80

# Or use different ports in docker-compose.yml
```

## 🔒 Security Notes

For production deployment:

1. Use environment variables for sensitive data
2. Enable HTTPS with SSL certificates (Let's Encrypt)
3. Configure MongoDB authentication
4. Set up firewall rules on the VM
5. Use Docker secrets for sensitive configuration
6. Regularly update Docker images and dependencies

## 📝 Additional Commands

### View Real-time Logs

```bash
docker-compose logs -f
docker-compose logs -f backend
```

### Execute Commands in Containers

```bash
# Access backend shell
docker exec -it mean-backend sh

# Access MongoDB
docker exec -it mean-mongodb mongosh dd_db
```

### Clean Up

```bash
# Stop and remove containers
docker-compose down

# Remove volumes (WARNING: deletes database)
docker-compose down -v

# Remove images
docker rmi your_dockerhub_username/mean-backend:latest
docker rmi your_dockerhub_username/mean-frontend:latest
```



### Request Examples

Create a tutorial:

```bash
curl -X POST http://localhost/api/tutorials \
  -H "Content-Type: application/json" \
  -d '{
    "title": "Docker Tutorial",
    "description": "Learn Docker basics",
    "published": false
  }'
```

Get all tutorials:

```bash
curl http://localhost/api/tutorials
```



```bash
# To stop the server without deleting
docker-compose stop

# To start again
docker-compose start
```
