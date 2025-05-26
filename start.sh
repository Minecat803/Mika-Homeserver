#!/bin/bash

sudo apt-get update
sudo apt-get install -y docker-compose

echo "Starting all Docker Compose services..."

find . -type d \( -name "srv*" -o -name "media*" \) -prune -false -o -name "docker-compose.yml" | while read compose_file; do
    dir=$(dirname "$compose_file")
    echo "Running in $dir"
    (cd "$dir" && docker compose up -d --force-recreate)
done

echo "All services started."
# Wait for all services to be up
sleep 10
echo "Waiting for services to be ready..."
sleep 10
echo "All services are now running."
# Check if any service is not running
if docker ps | grep -q "Up"; then
    echo "All services are running successfully."
else
    echo "Some services failed to start. Please check the logs."
fi
echo "your public IP address is:"
# Display the public IP address
curl ifconfig.me