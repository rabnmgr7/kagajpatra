#!/bin/bash
REGISTRY='harbor.registry.local'
echo "Registry URL: $REGISTRY"
echo "Building Docker images!!"
docker image build -t $REGISTRY/kagajpatra/web:$BUILD_NUMBER -f Dockerfile-web .

docker image build -t $REGISTRY/kagajpatra/nginx:$BUILD_NUMBER -f Dockerfile-nginx .

docker image tag mysql:latest $REGISTRY/kagajpatra/mysql:$BUILD_NUMBER

echo "Showing images!!"
docker images

echo "Logging in to Harbor Registry"
echo "Rabin@123" | docker login -u "admin" --password-stdin $REGISTRY > /dev/null
echo "Pushing Docker images to Harbor repository!!"
docker image push $REGISTRY/kagajpatra/web:$BUILD_NUMBER || true
docker image push $REGISTRY/kagajpatra/nginx:$BUILD_NUMBER || true
docker image push $REGISTRY/kagajpatra/mysql:$BUILD_NUMBER || true
