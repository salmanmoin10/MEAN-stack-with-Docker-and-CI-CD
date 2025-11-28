#!/bin/bash

# Deployment script for MEAN application
# This script pulls the latest Docker images and restarts the containers

set -e

echo "======================================"
echo "Starting deployment..."
echo "======================================"

# Load environment variables
if [ -f .env ]; then
    export $(cat .env | xargs)
else
    echo "Warning: .env file not found. Using default values."
fi

# Set default Docker username if not provided
DOCKER_USERNAME=${DOCKER_USERNAME:-yourdockerhubusername}

echo "Docker Username: $DOCKER_USERNAME"

# Login to Docker Hub (optional, for private images)
if [ ! -z "$DOCKER_PASSWORD" ]; then
    echo "Logging in to Docker Hub..."
    echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin
fi

# Stop and remove existing containers
echo "Stopping existing containers..."
# Stop containers
docker-compose stop

# Remove containers, networks, and volumes (orphans too)
docker-compose down --remove-orphans || true

# Force remove any stubborn containers with the same names
docker rm -f mean-backend mean-frontend mean-mongodb mean-nginx || true

# Pull the latest images
echo "Pulling latest Docker images..."
docker pull $DOCKER_USERNAME/mean-backend:latest || true
docker pull $DOCKER_USERNAME/mean-frontend:latest || true

# Start the containers
echo "Starting containers..."
docker-compose up -d

# Wait for services to be healthy
echo "Waiting for services to be healthy..."
sleep 10

# Check container status
echo "======================================"
echo "Container Status:"
echo "======================================"
docker-compose ps

# Check logs
echo "======================================"
echo "Recent logs:"
echo "======================================"
docker-compose logs --tail=20

# Test the application
echo "======================================"
echo "Testing application endpoints..."
echo "======================================"

# Wait a bit more for services to fully start
sleep 5

# Test backend
if curl -s http://localhost:8080/ > /dev/null; then
    echo "✓ Backend is responding"
else
    echo "✗ Backend is not responding"
fi

# Test nginx
if curl -s http://localhost/ > /dev/null; then
    echo "✓ Nginx is responding"
else
    echo "✗ Nginx is not responding"
fi

echo "======================================"
echo "Deployment completed!"
echo "======================================"
echo "Application is accessible at: http://localhost"
echo "Backend API is at: http://localhost/api"
echo ""
echo "To view logs: docker-compose logs -f"
echo "To stop: docker-compose down"
