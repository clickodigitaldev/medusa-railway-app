FROM node:20-alpine

WORKDIR /app

# Copy package files
COPY package*.json ./
COPY yarn.lock ./

# Install dependencies
RUN npm install

# Copy source code
COPY . .

# Build the application (this builds both backend and admin)
RUN npm run build

# Verify admin build
RUN ls -la .medusa/admin/ || echo "Admin build directory not found"

# Expose port
EXPOSE 9000

# Set environment variables
ENV NODE_ENV=production

# Start the application
CMD ["npm", "start"]
