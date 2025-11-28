# Quick Reference Guide

## 🚀 Quick Commands

### Local Development

```bash
# Backend
cd backend
npm install
node server.js

# Frontend
cd frontend
npm install
ng serve --port 8081
```

### Docker Commands

```bash
# Build images
docker build -t username/mean-backend:latest ./backend
docker build -t username/mean-frontend:latest ./frontend

# Push to Docker Hub
docker push username/mean-backend:latest
docker push username/mean-frontend:latest

# Run with Docker Compose
docker-compose up -d          # Start all services
docker-compose down           # Stop all services
docker-compose ps             # Check status
docker-compose logs -f        # View logs
docker-compose restart <service>  # Restart specific service
```

### VM Deployment

```bash
# Connect to VM
ssh ubuntu@YOUR_VM_IP

# Deploy application
cd ~/mean-app
./deploy.sh

# Check status
docker ps
docker-compose logs

# Stop/Start
docker-compose stop
docker-compose start
```

### Git Commands

```bash
# Initial setup
git init
git add .
git commit -m "Initial commit"
git remote add origin https://github.com/USERNAME/REPO.git
git push -u origin main

# Regular updates
git add .
git commit -m "Description"
git push
```

## 📝 Configuration Files

### .env

```env
DOCKER_USERNAME=your_dockerhub_username
```

### GitHub Secrets

- `DOCKER_USERNAME` - Docker Hub username
- `DOCKER_PASSWORD` - Docker Hub access token
- `SERVER_HOST` - VM IP address
- `SERVER_USER` - SSH username (ubuntu)
- `SSH_PRIVATE_KEY` - Private SSH key

## 🌐 URLs and Ports

| Service             | Port  | URL                       |
| ------------------- | ----- | ------------------------- |
| Application (Nginx) | 80    | http://YOUR_VM_IP         |
| Frontend (direct)   | 4200  | http://localhost:4200     |
| Backend (direct)    | 8080  | http://localhost:8080     |
| MongoDB             | 27017 | mongodb://localhost:27017 |

## 🔍 Useful Commands

### Check Docker Images

```bash
docker images | grep mean
```

### Check Running Containers

```bash
docker ps
```

### View Container Logs

```bash
docker logs mean-backend
docker logs mean-frontend
docker logs mean-mongodb
docker logs mean-nginx
```

### Execute in Container

```bash
docker exec -it mean-backend sh
docker exec -it mean-mongodb mongosh dd_db
```

### Check MongoDB Data

```bash
docker exec -it mean-mongodb mongosh dd_db --eval "db.tutorials.find().pretty()"
```

### Clean Up Docker

```bash
docker-compose down -v        # Remove containers and volumes
docker system prune -a        # Remove all unused containers, networks, images
```

## 🛠️ Troubleshooting

### Container won't start

```bash
docker-compose logs <service_name>
docker-compose restart <service_name>
docker-compose up -d --build
```

### Port already in use

```bash
# Windows
netstat -ano | findstr :80
netstat -ano | findstr :8080

# Linux
lsof -i :80
lsof -i :8080
```

### Reset everything

```bash
docker-compose down -v
docker-compose up -d --build
```

## 📊 API Endpoints

| Method | Endpoint           | Description          |
| ------ | ------------------ | -------------------- |
| GET    | /api/tutorials     | Get all tutorials    |
| GET    | /api/tutorials/:id | Get tutorial by ID   |
| POST   | /api/tutorials     | Create tutorial      |
| PUT    | /api/tutorials/:id | Update tutorial      |
| DELETE | /api/tutorials/:id | Delete tutorial      |
| DELETE | /api/tutorials     | Delete all tutorials |

## 🧪 Test Commands

```bash
# Test backend
curl http://localhost/api/tutorials

# Create tutorial
curl -X POST http://localhost/api/tutorials \
  -H "Content-Type: application/json" \
  -d '{"title":"Test","description":"Testing","published":false}'

# Get all tutorials
curl http://localhost/api/tutorials
```

## 📦 File Structure Reference

```
project/
├── .github/workflows/deploy.yml  # CI/CD pipeline
├── backend/
│   ├── Dockerfile               # Backend container
│   └── server.js                # Entry point
├── frontend/
│   ├── Dockerfile               # Frontend container
│   └── nginx.conf               # Frontend Nginx config
├── nginx/
│   └── nginx.conf               # Reverse proxy config
├── docker-compose.yml           # Container orchestration
└── deploy.sh                    # Deployment script
```
