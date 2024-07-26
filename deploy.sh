#!/bin/bash

# Define variables
ECR_REGISTRY="223263957253.dkr.ecr.ap-south-1.amazonaws.com"
IMAGE_NAME="php-app"
CONTAINER_NAME="myapp"
HOST_PORT="8080"   # Port on the host machine
CONTAINER_PORT="80" # Port in the Docker container

# Function to stop and remove the existing Docker container
stop_and_remove_container() {
    echo "Stopping the existing Docker container if it is running..."
    docker stop $CONTAINER_NAME || true
    docker rm $CONTAINER_NAME || true
}

# Function to pull the latest Docker image from ECR
pull_latest_image() {
    echo "Pulling the latest Docker image from ECR..."
    aws ecr get-login-password --region ap-south-1 | docker login --username AWS --password-stdin $ECR_REGISTRY
    docker pull $ECR_REGISTRY/$IMAGE_NAME:latest
}

# Function to start the Docker container
start_container() {
    echo "Starting the Docker container..."
    docker run -d --name $CONTAINER_NAME -p $HOST_PORT:$CONTAINER_PORT $ECR_REGISTRY/$IMAGE_NAME:latest
}

# Function to validate the service is running
validate_service() {
    echo "Validating the service is running..."
    if curl -f http://localhost:$HOST_PORT; then
        echo "Service is running successfully."
    else
        echo "Service validation failed."
        exit 1
    fi
}

# Run all functions
stop_and_remove_container
pull_latest_image
start_container
validate_service
