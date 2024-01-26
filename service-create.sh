#!/bin/bash
#Removing previously ran services
docker compose down || true
echo "Logging in to harbor"
cat ./.secrets/.password | docker login -u "admin" --password-stdin harbor.registry.local > /dev/null
echo "Deploying services"
# Starting new services
docker compose up -d
