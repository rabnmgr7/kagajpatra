#!/bin/bash
REGISTRY="harbor.registry.local"
echo "Showing images!!"
docker images | grep -i "kagajpatra"
docker image tag $REGISTRY/kagajpatra/web:$BUILD_NUMBER $REGISTRY/kagajpatra/web_v1:$BUILD_NUMBER

docker image tag $REGISTRY/kagajpatra/nginx:$BUILD_NUMBER $REGISTRY/kagajpatra/nginx_v1:$BUILD_NUMBER

docker image tag $REGISTRY/kagajpatra/mysql:$BUILD_NUMBER $REGISTRY/kagajpatra/mysql_v1:$BUILD_NUMBER

echo "Logging in to Harbor Registry"
cat ./.secrets/.password | docker login -u "admin" --password-stdin $REGISTRY > /dev/null
echo "Pushing Docker images to Harbor repository!!"
docker image push $REGISTRY/kagajpatra/web_v1:$BUILD_NUMBER || true
docker image push $REGISTRY/kagajpatra/nginx_v1:$BUILD_NUMBER || true
docker image push $REGISTRY/kagajpatra/mysql_v1:$BUILD_NUMBER || true
