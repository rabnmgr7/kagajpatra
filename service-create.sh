#!/bin/bash
#Removing previously ran services
docker compose down || true
echo "Deploying services"
# Starting new services
docker compose up -d
