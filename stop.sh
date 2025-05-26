#!/bin/bash

echo "Stopping all Docker Compose services..."

find . -type d \( -name "srv*" -o -name "media*" \) -prune -false -o -name "docker-compose.yml" | while read compose_file; do
    dir=$(dirname "$compose_file")
    echo "Running in $dir"
    (cd "$dir" && docker compose down --remove-orphans)
    if [ $? -ne 0 ]; then
        echo "Failed to stop services in $dir"
    else
        echo "Successfully stopped services in $dir"
    fi
done