#!/bin/bash

sudo apt-get update
sudo apt-get install -y docker-compose

echo "Starting all Docker Compose services..."

find . -type d \( -name "srv*" -o -name "media*" \) -prune -false -o -name "docker-compose.yml" | while read compose_file; do
    dir=$(dirname "$compose_file")
    echo "Running in $dir"
    (cd "$dir" && docker compose up -d --force-recreate)
done