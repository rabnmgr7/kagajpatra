#!/bin/bash
echo "Building Docker images!!"
docker image build -t harbor.registry.local/kagajpatra/web:$BUILD_NUMBER -f Dockerfile-web .

docker image build -t harbor.registry.local/kagajpatra/nginx:$BUILD_NUMBER -f Dockerfile-nginx .

docker image tag mysql:latest harbor.registry.local/kagajpatra/mysql:$BUILD_NUMBER

echo "Showing images!!"
docker images

echo "Pushing Docker images to Harbor repository!!"
docker image push harbor.registry.local/kagajpatra/web:$BUILD_NUMBER || true

docker image push harbor.registry.local/kagajpatra/nginx:$BUILD_NUMBER || true
