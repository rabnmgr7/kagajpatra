#!/bin/bash
REGISTRY="harbor.registry.local"
echo "Showing images!!"
docker images | grep -i "kagajpatra"
docker image tag $REGISTRY/kagajpatra/web:$BUILD_NUMBER $REGISTRY/kagajpatra/web:latest

docker image tag $REGISTRY/kagajpatra/nginx:$BUILD_NUMBER $REGISTRY/kagajpatra/nginx:latest

docker image tag $REGISTRY/kagajpatra/mysql:$BUILD_NUMBER $REGISTRY/kagajpatra/mysql:latest

echo "Logging in to Harbor Registry"
echo "Rabin@123" | docker login -u "admin" --password-stdin $REGISTRY > /dev/null
echo "Pushing Docker images to Harbor repository!!"
docker image push $REGISTRY/kagajpatra/web:v1 || true
docker image push $REGISTRY/kagajpatra/nginx:v1 || true
docker image push $REGISTRY/kagajpatra/mysql:v1 || true
