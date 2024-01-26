#!/bin/bash
#Removing previously ran services
echo "Logging into Harbor registry"
docker login harbor.registry.local || true
echo "Deploying services"
docker compose down || true
# Starting new services
docker compose up -d
