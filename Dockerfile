# --- STAGE 1: Build ---
FROM node:18-alpine AS builder
WORKDIR /app

# Copy package files first to make 'npm install' fast (Caching)
COPY app/package*.json ./
RUN npm install

# Copy the actual code
COPY app/ .

# --- STAGE 2: Runtime ---
FROM node:18-alpine
WORKDIR /app

# Best Practice: Run as non-root user for security
USER node

# Copy only the files we need from the builder stage
COPY --from=builder /app /app

# Expose the port
EXPOSE 3000

# Start the app
CMD ["node", "server.js"]
