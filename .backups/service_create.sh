#!/bin/bash
echo "Showing previous services:"
docker service ls
echo "Removing previous service if present:"
docker service rm kagajpatra_web kagajpatra_db kagajpatra_nginx || true
echo "Deploying services as stack"
docker stack deploy -c docker-compose.yaml kagajpatra
echo "Done!"
