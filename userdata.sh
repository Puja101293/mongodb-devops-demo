#!/bin/bash
# Update system and install Docker
yum update -y
amazon-linux-extras enable docker
yum install -y docker
systemctl start docker
systemctl enable docker

# Add ec2-user to docker group (so you don’t always need sudo)
usermod -aG docker ec2-user

# Run MongoDB container with custom credentials
docker run -d \
  --name mongodb \
  -p 27017:27017 \
  -e MONGO_INITDB_ROOT_USERNAME=puja \
  -e MONGO_INITDB_ROOT_PASSWORD=MyStrongPass123 \
  mongo:6.0

# Log setup result
echo "MongoDB container deployed successfully on $(date)" >> /var/log/mongo-setup.log
