#!/bin/bash
docker compose down || true
docker image rm kagajpatra:v1 || true
docker compose up
