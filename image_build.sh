#!/bin/bash
echo "Checking for previously running services..."
docker service ls
echo "Removing Running kagajpatra services and network if running..."
docker service rm kagajpatra_web kagajpatra_db kagajpatra_nginx || true
docker network rm -f kagajpatra_server_network
echo "Removing previous previously built images..."
docker image rm -f kagajpatra_web:latest kagajpatra_nginx:latest || true

echo "Building images from Dockerfiles..."
docker image build -t kagajpatra_web:latest -f Dockerfile-web .
docker image build -t kagajpatra_nginx:latest -f Dockerfile-nginx .
