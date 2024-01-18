#!/bin/bash
echo "Showing previous compose:"
docker compose ps
echo "Removing previous compose if present:"
docker compose down || true
echo "Removing previous buit image:"
docker image rm -f kagajpatra-web:latest || true
echo "Composing docker compose file"
docker compose up
