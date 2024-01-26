#!/bin/bash

echo "Stopping previously built container"
docker container stop kagajpatra_web || true
docker container stop kagajpatra_nginx || true
docker container stop kagajpatra_mysql || true

echo "Removing previously built container"
docker container rm kagajpatra_web || true 
docker container rm kagajpatra_nginx || true
docker container rm kagajpatra_mysql || true

echo "Creating new container"
docker run -itd --name kagajpatra_web -p 5001:5000 harbor.registry.local/kagajpatra/web:$BUILD_NUMBER
docker run -itd --name kagajpatra_mysql -p 3307:3306 harbor.registry.local/kagajpatra/web:$BUILD_NUMBER
docker run -itd --name kagajpatra_nginx -p 8082:80 harbor.registry.local/kagajpatra/web:$BUILD_NUMBER
