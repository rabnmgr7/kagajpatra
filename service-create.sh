#!/bin/bash
#Removing previously ran services
echo "Logging into Harbor registry"
echo "$HARBOR_REGISTRY_PASSWORD" | docker login -u "$HARBOR_REGISTRY_USER" --password-stdin harbor.registry.local > /dev/null
docker compose down || true
# Starting new services
docker compose up -d
