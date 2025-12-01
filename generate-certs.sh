#!/bin/bash

# Create certificates directory
mkdir -p ./nginx/certs

# Generate private key
openssl genrsa -out ./nginx/certs/server.key 2048

# Generate certificate signing request
openssl req -new -key ./nginx/certs/server.key -out ./nginx/certs/server.csr -subj "/C=US/ST=State/L=City/O=Organization/OU=OrgUnit/CN=localhost"

# Generate self-signed certificate (valid for 365 days)
openssl x509 -req -days 365 -in ./nginx/certs/server.csr -signkey ./nginx/certs/server.key -out ./nginx/certs/server.crt

# Create certificate bundle
cat ./nginx/certs/server.crt > ./nginx/certs/server.pem
cat ./nginx/certs/server.key >> ./nginx/certs/server.pem

# Set proper permissions
chmod 600 ./nginx/certs/server.key
chmod 644 ./nginx/certs/server.crt
chmod 644 ./nginx/certs/server.pem

# Clean up CSR file
rm ./nginx/certs/server.csr

echo "Self-signed certificates generated successfully!"
echo "Certificate: ./nginx/certs/server.crt"
echo "Private Key: ./nginx/certs/server.key"
echo "Bundle: ./nginx/certs/server.pem"