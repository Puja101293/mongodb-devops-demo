#!/bin/bash
# Install Docker
yum update -y
amazon-linux-extras enable docker
yum install -y docker
systemctl start docker
systemctl enable docker

# Run MongoDB container
docker run -d --name mongodb -p 27017:27017 -e MONGO_INITDB_ROOT_USERNAME=admin -e MONGO_INITDB_ROOT_PASSWORD=password mongo:6.0
