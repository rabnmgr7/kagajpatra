#!/bin/bash
#Removing previously ran services
echo "Deploying services"
docker compose down || true
# Starting new services
docker compose up -d
