FROM node:18-slim

WORKDIR /app/

# Set NODE_OPTIONS to allow legacy OpenSSL provider
ENV NODE_OPTIONS=--openssl-legacy-provider

# Copy package files and install dependencies
COPY package.json ./
RUN npm install --legacy-peer-deps

# Copy TDWeb files to public directory
RUN mkdir -p public/
COPY . .
RUN cp -v node_modules/tdweb/dist/* public/

# Set Telegram API environment variables (can be overridden at runtime)
ARG TELEGRAM_API_ID
ENV REACT_APP_TELEGRAM_API_ID=${TELEGRAM_API_ID}
ARG TELEGRAM_API_HASH
ENV REACT_APP_TELEGRAM_API_HASH=${TELEGRAM_API_HASH}

# Expose the development server port
EXPOSE 3000

# Start the development server
CMD ["npm", "start"] 