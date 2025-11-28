# MEAN Stack Application - Complete Deployment Guide

This guide walks you through every step of deploying the MEAN stack application from scratch.

## 📋 Prerequisites Checklist

Before starting, ensure you have:

- [ ] GitHub account created
- [ ] Docker Hub account created
- [ ] Cloud provider account (AWS/Azure/GCP)
- [ ] Git installed on local machine
- [ ] Docker installed locally (for testing)

## 🚀 Step-by-Step Deployment

### Phase 1: Repository Setup (10 minutes)

#### 1.1 Create GitHub Repository

1. Go to [GitHub](https://github.com) and log in
2. Click "New repository" button
3. Repository settings:
   - Name: `mean-crud-app` (or your preferred name)
   - Description: "MEAN Stack CRUD Application with Docker and CI/CD"
   - Visibility: Public or Private
   - **DO NOT** initialize with README (we already have one)
4. Click "Create repository"

#### 1.2 Initialize Local Git Repository

Open terminal in your project directory:

```bash
cd "C:\Users\Salman Moin\Desktop\crud-dd-task-mean-app\crud-dd-task-mean-app"

# Initialize git
git init

# Add all files
git add .

# Create initial commit
git commit -m "Initial commit: MEAN stack application with Docker setup"

# Add remote repository (replace with your repository URL)
git remote add origin https://github.com/YOUR_USERNAME/YOUR_REPO_NAME.git

# Push to GitHub
git branch -M main
git push -u origin main
```

#### 1.3 Verify Repository

1. Refresh your GitHub repository page
2. Verify all files are uploaded:
   - ✅ backend/ folder with Dockerfile
   - ✅ frontend/ folder with Dockerfile
   - ✅ nginx/ folder with nginx.conf
   - ✅ .github/workflows/deploy.yml
   - ✅ docker-compose.yml
   - ✅ deploy.sh
   - ✅ README.md

---

### Phase 2: Docker Hub Setup (5 minutes)

#### 2.1 Create Docker Hub Account

1. Go to [Docker Hub](https://hub.docker.com)
2. Sign up for a free account
3. Verify your email address

#### 2.2 Create Access Token

1. Log in to Docker Hub
2. Click your username → Account Settings
3. Go to "Security" tab
4. Click "New Access Token"
5. Token description: "GitHub Actions CI/CD"
6. Access permissions: "Read, Write, Delete"
7. Click "Generate"
8. **IMPORTANT**: Copy the token immediately (you won't see it again)

#### 2.3 Test Docker Hub Login

On your local machine:

```bash
# Login to Docker Hub
docker login

# Enter your Docker Hub username
# Paste the access token as password
```

---

### Phase 3: Build and Push Docker Images (15 minutes)

#### 3.1 Create .env File

```bash
# Create .env file in project root
cd "C:\Users\Salman Moin\Desktop\crud-dd-task-mean-app\crud-dd-task-mean-app"

# Create .env file (replace with your Docker Hub username)
echo "DOCKER_USERNAME=your_dockerhub_username" > .env
```

Or create manually with this content:

```
DOCKER_USERNAME=your_dockerhub_username
```

#### 3.2 Build Images Locally

```bash
# Build backend image
docker build -t your_dockerhub_username/mean-backend:latest ./backend

# Build frontend image
docker build -t your_dockerhub_username/mean-frontend:latest ./frontend
```

#### 3.3 Test Images Locally

```bash
# Test with Docker Compose
docker-compose up -d

# Wait 30 seconds for services to start
timeout 30

# Check if services are running
docker-compose ps

# Check logs
docker-compose logs

# Test the application
# Open browser: http://localhost
```

#### 3.4 Push Images to Docker Hub

```bash
# Push backend image
docker push your_dockerhub_username/mean-backend:latest

# Push frontend image
docker push your_dockerhub_username/mean-frontend:latest
```

#### 3.5 Verify on Docker Hub

1. Go to Docker Hub
2. Navigate to "Repositories"
3. Verify both images are present:
   - `your_username/mean-backend`
   - `your_username/mean-frontend`
4. Check the tags show "latest"
5. Take screenshot for documentation

#### 3.6 Clean Up Local Test

```bash
# Stop local containers
docker-compose down
```

---

### Phase 4: Cloud VM Setup (20 minutes)

#### 4.1 Create Ubuntu VM

Choose your cloud provider:

**AWS EC2:**

1. Go to EC2 Dashboard
2. Click "Launch Instance"
3. Choose "Ubuntu Server 22.04 LTS"
4. Instance type: t2.medium (minimum)
5. Create or select key pair for SSH
6. Network settings:
   - Allow SSH (port 22) from your IP
   - Allow HTTP (port 80) from anywhere
7. Storage: 20 GB minimum
8. Launch instance
9. Note the public IP address

**Azure VM:**

1. Go to Virtual Machines
2. Click "Create" → "Azure virtual machine"
3. Choose "Ubuntu Server 22.04 LTS"
4. Size: Standard_B2s or larger
5. Authentication: SSH public key
6. Inbound ports: SSH (22), HTTP (80)
7. Review and create
8. Note the public IP address

**GCP Compute Engine:**

1. Go to Compute Engine
2. Click "Create Instance"
3. Choose "Ubuntu 22.04 LTS"
4. Machine type: e2-medium or larger
5. Firewall: Allow HTTP traffic
6. Create
7. Note the external IP address

#### 4.2 Configure Security Groups/Firewall

Ensure these ports are open:

- Port 22 (SSH) - from your IP only
- Port 80 (HTTP) - from anywhere (0.0.0.0/0)

#### 4.3 Connect to VM

```bash
# SSH into your VM (replace with your details)
ssh -i your-key.pem ubuntu@YOUR_VM_IP

# Or for Azure/GCP
ssh your_username@YOUR_VM_IP
```

#### 4.4 Install Docker on VM

```bash
# Update system
sudo apt update && sudo apt upgrade -y

# Install Docker
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh

# Add user to docker group
sudo usermod -aG docker $USER

# Install Docker Compose
sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Install additional tools
sudo apt install -y git curl wget

# Verify installations
docker --version
docker-compose --version

# IMPORTANT: Log out and log back in
exit
```

Log back in:

```bash
ssh ubuntu@YOUR_VM_IP
```

#### 4.5 Verify Docker Access

```bash
# Should work without sudo now
docker ps
docker-compose --version
```

---

### Phase 5: Deploy Application on VM (15 minutes)

#### 5.1 Create Application Directory

```bash
# Create directory
mkdir -p ~/mean-app
cd ~/mean-app
```

#### 5.2 Clone Repository

```bash
# Clone your repository (replace with your URL)
git clone https://github.com/YOUR_USERNAME/YOUR_REPO_NAME.git .

# Or if the repository is in a subfolder
git clone https://github.com/YOUR_USERNAME/YOUR_REPO_NAME.git
cd YOUR_REPO_NAME
```

#### 5.3 Create .env File on VM

```bash
# Create .env file
nano .env
```

Add this content (replace with your Docker Hub username):

```
DOCKER_USERNAME=your_dockerhub_username
```

Save and exit (Ctrl+X, Y, Enter)

#### 5.4 Make Deploy Script Executable

```bash
chmod +x deploy.sh
```

#### 5.5 Pull Images and Deploy

```bash
# Pull images from Docker Hub
docker pull your_dockerhub_username/mean-backend:latest
docker pull your_dockerhub_username/mean-frontend:latest

# Start services
./deploy.sh
```

#### 5.6 Verify Deployment

```bash
# Check running containers
docker ps

# Should see 4 containers:
# - mean-mongodb
# - mean-backend
# - mean-frontend
# - mean-nginx

# Check logs
docker-compose logs -f

# Test locally on VM
curl http://localhost
curl http://localhost/api/tutorials
```

#### 5.7 Test from Your Browser

Open your browser and navigate to:

```
http://YOUR_VM_IP
```

You should see the Angular application!

---

### Phase 6: Setup CI/CD Pipeline (20 minutes)

#### 6.1 Generate SSH Key for CI/CD

On your **local machine**:

```bash
# Generate SSH key
ssh-keygen -t rsa -b 4096 -f ~/.ssh/mean-deploy -N ""

# This creates two files:
# - ~/.ssh/mean-deploy (private key)
# - ~/.ssh/mean-deploy.pub (public key)
```

#### 6.2 Add Public Key to VM

```bash
# Copy public key to VM
ssh-copy-id -i ~/.ssh/mean-deploy.pub ubuntu@YOUR_VM_IP

# Test connection
ssh -i ~/.ssh/mean-deploy ubuntu@YOUR_VM_IP
```

If `ssh-copy-id` doesn't work:

```bash
# Manually copy public key
cat ~/.ssh/mean-deploy.pub

# SSH to your VM
ssh ubuntu@YOUR_VM_IP

# Add the public key
mkdir -p ~/.ssh
nano ~/.ssh/authorized_keys
# Paste the public key, save and exit

# Set correct permissions
chmod 700 ~/.ssh
chmod 600 ~/.ssh/authorized_keys
exit
```

#### 6.3 Get Private Key Content

```bash
# Display private key
cat ~/.ssh/mean-deploy

# Copy the entire output including:
# -----BEGIN RSA PRIVATE KEY-----
# ...content...
# -----END RSA PRIVATE KEY-----
```

#### 6.4 Configure GitHub Secrets

1. Go to your GitHub repository
2. Click "Settings" tab
3. Navigate to "Secrets and variables" → "Actions"
4. Click "New repository secret"

Add these secrets one by one:

| Secret Name       | Value                                         |
| ----------------- | --------------------------------------------- |
| `DOCKER_USERNAME` | Your Docker Hub username                      |
| `DOCKER_PASSWORD` | Your Docker Hub access token (from Phase 2.2) |
| `SERVER_HOST`     | Your VM's public IP address                   |
| `SERVER_USER`     | SSH username (usually `ubuntu`)               |
| `SSH_PRIVATE_KEY` | Private key content (from step 6.3)           |

For each secret:

- Click "New repository secret"
- Enter the name
- Paste the value
- Click "Add secret"

#### 6.5 Verify Workflow File

1. In your repository, navigate to `.github/workflows/deploy.yml`
2. Verify the file exists and is properly formatted
3. The workflow should trigger on push to main/master branch

#### 6.6 Test CI/CD Pipeline

```bash
# On your local machine, make a small change
cd "C:\Users\Salman Moin\Desktop\crud-dd-task-mean-app\crud-dd-task-mean-app"

# Make a test change
echo "# CI/CD Test" >> README.md

# Commit and push
git add .
git commit -m "Test CI/CD pipeline"
git push origin main
```

#### 6.7 Monitor Pipeline Execution

1. Go to your GitHub repository
2. Click "Actions" tab
3. You should see a workflow running
4. Click on the workflow to see details
5. Monitor each step:
   - Checkout code ✓
   - Build and push backend ✓
   - Build and push frontend ✓
   - Deploy to server ✓

#### 6.8 Verify Auto-Deployment

After the workflow completes:

```bash
# SSH to your VM
ssh ubuntu@YOUR_VM_IP

# Check containers were restarted
cd ~/mean-app
docker ps

# Check recent logs
docker-compose logs --tail=50
```

Test in browser: `http://YOUR_VM_IP`

---

### Phase 7: Documentation and Screenshots (15 minutes)

#### 7.1 Take Screenshots

Capture screenshots of:

1. **GitHub Actions**

   - Workflow file in repository
   - Successful pipeline execution
   - Each step completion

2. **Docker Hub**

   - Repository list showing both images
   - Backend image details
   - Frontend image details

3. **Application Running**

   - Home page
   - Tutorial list page
   - Add tutorial form
   - Tutorial details page

4. **Infrastructure**
   - Cloud provider VM dashboard
   - Docker containers running (`docker ps`)
   - Nginx configuration
   - Docker Compose services

#### 7.2 Add Screenshots to Repository

```bash
# On your local machine
cd "C:\Users\Salman Moin\Desktop\crud-dd-task-mean-app\crud-dd-task-mean-app"

# Copy your screenshots to .screenshots folder
# Name them according to .screenshots/README.md

# Add and commit
git add .screenshots/
git commit -m "Add deployment screenshots"
git push origin main
```

#### 7.3 Update README.md

If needed, update the README.md with any specific details about your deployment:

- Your Docker Hub username
- VM provider and instance type used
- Any specific configuration changes

---

### Phase 8: Final Verification (10 minutes)

#### 8.1 Complete Functionality Test

Test all CRUD operations:

1. **Create Tutorial**

   - Go to "Add Tutorial"
   - Title: "Docker Tutorial"
   - Description: "Learn Docker basics"
   - Click "Submit"

2. **Read Tutorials**

   - Go to "Tutorials List"
   - Verify the tutorial appears

3. **Update Tutorial**

   - Click on a tutorial
   - Click "Edit"
   - Update the description
   - Click "Update"

4. **Search Tutorial**

   - Use search box in tutorials list
   - Search by title

5. **Delete Tutorial**
   - Click on a tutorial
   - Click "Delete"
   - Verify it's removed

#### 8.2 Test CI/CD End-to-End

Make a meaningful code change:

```bash
# Edit backend/server.js
# Change the welcome message

cd "C:\Users\Salman Moin\Desktop\crud-dd-task-mean-app\crud-dd-task-mean-app"

# Edit the file (example change)
# In backend/server.js, line 21:
# FROM: res.json({ message: "Welcome to Test application." });
# TO:   res.json({ message: "Welcome to MEAN Stack CRUD Application!" });

# Commit and push
git add backend/server.js
git commit -m "Update welcome message"
git push origin main
```

Wait for pipeline to complete, then verify:

```bash
# Test backend API
curl http://YOUR_VM_IP/api/tutorials

# Should see updated message
```

#### 8.3 Check All Services

```bash
# SSH to VM
ssh ubuntu@YOUR_VM_IP

# Check all containers are healthy
docker ps

# Verify database
docker exec -it mean-mongodb mongosh dd_db --eval "db.tutorials.find()"

# Check resource usage
docker stats --no-stream
```

#### 8.4 Final Checklist

Ensure everything is complete:

- [ ] Repository pushed to GitHub with all files
- [ ] Docker images available on Docker Hub
- [ ] VM running with all containers
- [ ] Application accessible via port 80
- [ ] Nginx reverse proxy working
- [ ] CI/CD pipeline configured and tested
- [ ] All GitHub secrets configured
- [ ] Screenshots taken and added
- [ ] README.md is comprehensive
- [ ] All CRUD operations working

---

## 🎯 Deliverables Summary

Your GitHub repository should contain:

1. **Application Code**

   - Backend (Node.js/Express)
   - Frontend (Angular 15)

2. **Docker Files**

   - `backend/Dockerfile`
   - `frontend/Dockerfile`
   - `docker-compose.yml`
   - `.dockerignore` files

3. **Infrastructure as Code**

   - `nginx/nginx.conf` (reverse proxy)
   - `frontend/nginx.conf` (frontend server)

4. **CI/CD Configuration**

   - `.github/workflows/deploy.yml`
   - `deploy.sh`

5. **Documentation**

   - `README.md` (comprehensive guide)
   - `DEPLOYMENT_GUIDE.md` (this file)
   - `.screenshots/` (with all screenshots)

6. **Configuration**
   - `.env.example`
   - `.gitignore`

---

## 🔧 Troubleshooting Common Issues

### Issue 1: Docker Build Fails

**Solution:**

```bash
# Check Dockerfile syntax
cat backend/Dockerfile

# Build with no cache
docker build --no-cache -t your_username/mean-backend:latest ./backend

# Check for port conflicts
netstat -ano | findstr :8080
```

### Issue 2: GitHub Actions Fails

**Solution:**

```bash
# Verify all secrets are set correctly
# Re-generate SSH key if needed
# Check VM is accessible: ssh ubuntu@YOUR_VM_IP
# Verify deploy.sh has execution permissions on VM
```

### Issue 3: Containers Won't Start

**Solution:**

```bash
# Check logs
docker-compose logs

# Restart specific service
docker-compose restart backend

# Rebuild and restart
docker-compose up -d --build
```

### Issue 4: Can't Access Application

**Solution:**

```bash
# Check firewall rules on VM
sudo ufw status

# Verify containers are running
docker ps

# Check Nginx logs
docker-compose logs nginx

# Test locally on VM
curl http://localhost
```

### Issue 5: Database Connection Failed

**Solution:**

```bash
# Check MongoDB is running
docker ps | grep mongodb

# Check MongoDB logs
docker logs mean-mongodb

# Verify connection string in backend
docker exec mean-backend env | grep MONGODB
```

---

## 📞 Support and Next Steps

### For Demonstration

When asked to demonstrate:

```bash
# Start stopped server
ssh ubuntu@YOUR_VM_IP
cd ~/mean-app
docker-compose start

# Or if containers were removed
docker-compose up -d

# Check status
docker-compose ps
```

### To Make Changes

```bash
# Local changes
git add .
git commit -m "Description of changes"
git push origin main

# Pipeline will automatically:
# 1. Build new images
# 2. Push to Docker Hub
# 3. Deploy to VM
```

### To Stop Server (Keep Infrastructure)

```bash
# SSH to VM
ssh ubuntu@YOUR_VM_IP

# Stop containers
cd ~/mean-app
docker-compose stop

# Restart later
docker-compose start
```

---

## ✅ Success Criteria

Your deployment is successful when:

1. ✅ All files committed to GitHub
2. ✅ Docker images visible on Docker Hub
3. ✅ Application accessible at `http://YOUR_VM_IP`
4. ✅ All CRUD operations functional
5. ✅ Nginx reverse proxy routing correctly
6. ✅ CI/CD pipeline runs successfully
7. ✅ Auto-deployment works on git push
8. ✅ All screenshots documented
9. ✅ README.md is comprehensive

---

**Congratulations!** You have successfully:

- Containerized a full-stack MEAN application
- Set up Docker Compose for multi-container orchestration
- Configured Nginx as a reverse proxy
- Implemented a complete CI/CD pipeline
- Deployed to a cloud VM
- Created comprehensive documentation

Your application is now production-ready with automated deployment! 🚀
