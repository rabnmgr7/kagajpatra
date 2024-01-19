#!/bin/bash
echo "Deploying services as stack..."
docker stack deploy -c docker-stack.yaml kagajpatra

echo "Done!"
docker service ls
