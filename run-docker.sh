#!/bin/bash

echo "🚀 Stopping existing containers..."
docker stop new_container dev_container 2>/dev/null
docker rm new_container dev_container 2>/dev/null

echo "📦 Building Node.js Docker image..."
docker build -t image_container1 .

echo "📂 Running Node.js backend on port 5001..."
docker run -d -p 5001:5001 \
  --name new_container \
  image_container1

echo "🌐 Running Nginx frontend on port 8080..."
docker run -d -p 8080:80 \
  -v "$(pwd)/public:/usr/share/nginx/html" \
  --name dev_container \
  nginx

echo "✅ All services are up!"
echo "Frontend: http://localhost:8080"
echo "Backend:  http://localhost:5001"
