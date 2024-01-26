#!/bin/bash
#Removing previously ran services
docker compose down || true
echo "Logging in to harbor"
echo "Rabin@123" | docker login -u "admin" --password-stdin harbor.registry.local > /dev/null
docker compose down || true
echo "Deploying services"
# Starting new services
docker compose up -d
