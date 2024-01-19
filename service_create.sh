#!/bin/bash
echo "Checking for previously running services:"
docker service ls

echo "Removing services and network if running."
docker service rm kagajpatra_web kagajpatra_db kagajpatra_nginx || true
docker network rm -f kagajpatra_server_network

echo "Deploying services as stack:"
docker stack deploy -c docker-stack.yaml kagajpatra

echo "Done! showing running services:"
docker service ls
