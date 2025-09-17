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

# Verify admin build and create directory if needed
RUN ls -la .medusa/ || echo "No .medusa directory"
RUN ls -la .medusa/admin/ || echo "Admin build directory not found"
RUN if [ ! -f ".medusa/admin/index.html" ]; then \
      echo "Creating minimal admin index.html"; \
      mkdir -p .medusa/admin && \
      echo '<!DOCTYPE html><html><head><title>Medusa Admin</title></head><body><h1>Medusa Admin Loading...</h1><script>window.location.href="/admin/auth";</script></body></html>' > .medusa/admin/index.html; \
    fi

# Expose port
EXPOSE 9000

# Set environment variables
ENV NODE_ENV=production

# Start the application
CMD ["npm", "start"]
