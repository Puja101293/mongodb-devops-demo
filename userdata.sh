#!/bin/bash
set -e
apt-get update -y
apt-get install -y apt-transport-https ca-certificates curl gnupg lsb-release
# Install Docker
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh
usermod -aG docker ubuntu || true
# Start Docker service
systemctl enable docker
systemctl start docker
# Run MongoDB container (change credentials for production)
docker run -d --name mongodb \
  -p 27017:27017 \
  -e MONGO_INITDB_ROOT_USERNAME=admin \
  -e MONGO_INITDB_ROOT_PASSWORD=adminpwd \
  mongo:6.0 --bind_ip 0.0.0.0
