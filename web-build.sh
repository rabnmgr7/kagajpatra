#!/bin/bash
echo "Checking previously built image:"
docker images | grep "kagajpatra_web:latest"

echo "Removing previous buit image:"
docker image rm -f kagajpatra_web:latest || true

echo "Composing docker compose file"
docker image build -t kagajpatra_web:latest .
