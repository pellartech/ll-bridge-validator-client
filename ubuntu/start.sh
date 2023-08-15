#!/bin/bash

# Update the package index
sudo apt update

# Install packages to allow apt to use a repository over HTTPS
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common

# Add Docker's official GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --yes --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# Add Docker repository
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Update the package index again
sudo apt update

# Install Docker
sudo apt install -y docker-ce docker-ce-cli containerd.io

# Add your user to the "docker" group to run Docker without sudo
sudo usermod -aG docker $USER

# Install Docker Compose
sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# read env
sudo docker compose up -d

url="http://localhost:2710"
response=$(curl -s "$url/api/v1/sites/hello")

for i in {1..10}; do
    if [ ! -z "$response" ]; then
        break
    fi

    echo "Waiting for the application to start..."
    sleep 10
    response=$(curl -s "$url/api/v1/sites/hello")
done

if [ -z "$response" ]; then
    echo "The application failed to start."
    exit 1
fi

echo "The application started successfully."

lightlinkValidator=$(curl -s "$url/api/v1/accounts/lightlink/standard/validator")
echo "LightLink validator: $lightlinkValidator"

ethereumValidator=$(curl -s "$url/api/v1/accounts/ethereum/standard/validator")
echo "Ethereum validator: $ethereumValidator"
