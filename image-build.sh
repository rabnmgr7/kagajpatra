#!/bin/bash
echo "Removing previous buit image:"
docker image rm -f kagajpatra_web:latest kagajpatra_nginx:latest || true

echo "Composing docker compose file"
docker image build -t kagajpatra_web:latest -f Dockerfile-web .
docker image build -t kagajpatra_nginx:latest -f Dockerfile-nginx .
