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
sudo docker-compose pull  && docker compose up -d

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

lightlinkValidatorResp=$(curl -s "$url/api/v1/accounts/lightlink/standard/validator")
for i in {1..10}; do
    if [ ! -z "$lightlinkValidatorResp" ]; then
        break
    fi

    echo "Waiting for the LightLink validator to be created..."
    sleep 10
    lightlinkValidatorResp=$(curl -s "$url/api/v1/accounts/lightlink/standard/validator")
done

if [ -z "$lightlinkValidatorResp" ]; then
    echo "The LightLink validator failed to be created."
    exit 1
fi

echo "The LightLink validator was created successfully."

ethereumValidatorResp=$(curl -s "$url/api/v1/accounts/ethereum/standard/validator")
for i in {1..10}; do
    if [ ! -z "$ethereumValidatorResp" ]; then
        break
    fi

    echo "Waiting for the Ethereum validator to be created..."
    sleep 10
    ethereumValidatorResp=$(curl -s "$url/api/v1/accounts/ethereum/standard/validator")
done

if [ -z "$ethereumValidatorResp" ]; then
    echo "The Ethereum validator failed to be created."
    exit 1
fi

echo "The Ethereum validator was created successfully."

bscValidatorResp=$(curl -s "$url/api/v1/accounts/bsc/standard/validator")
for i in {1..10}; do
    if [ ! -z "$bscValidatorResp" ]; then
        break
    fi

    echo "Waiting for the Bsc validator to be created..."
    sleep 10
    bscValidatorResp=$(curl -s "$url/api/v1/accounts/bsc/standard/validator")
done

if [ -z "$bscValidatorResp" ]; then
    echo "The Bsc validator failed to be created."
    exit 1
fi

echo "The Bsc validator was created successfully."