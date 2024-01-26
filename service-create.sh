#!/bin/bash
#Removing previously ran services
docker login harbor.registry.local
docker compose down || true
# Starting new services
docker compose up -d
