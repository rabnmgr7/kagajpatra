#!/bin/bash
sed -i 's/web/web_v1/g' docker-compose.yml
sed -i 's/nginx/nginx_v1/g' docker-compose.yml
sed -i 's/mysql/mysql_v1/g' docker-compose.yml
echo "Which user is running these commands!"
whoami
#Removing previously ran services
docker compose down || true
echo "Logging in to harbor"
cat ./.secrets/.password | docker login -u "admin" --password-stdin harbor.registry.local > /dev/null
echo "Deploying services"
# Starting new services
docker compose up -d
docker compose ps
docker container ps -a | grep -i "kagajpatra"
