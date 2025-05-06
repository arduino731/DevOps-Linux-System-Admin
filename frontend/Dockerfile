# Use official Nginx image
FROM nginx:alpine

# Copy static site content into Nginx web root
COPY public/ /usr/share/nginx/html

# Expose port 80 (internally mapped to 8080 in docker-compose)
EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
