# Use a lightweight Node.js image
FROM node:22-alpine

# Set the working directory inside the container
WORKDIR /usr/src/app

# Copy the backend app files
COPY . .

# Install dependencies
RUN npm install

# Expose backend port
EXPOSE 5001

# Start the backend
CMD ["node", "app.js"]
