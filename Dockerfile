FROM alpine:latest

# Install OpenSSL
RUN apk add --no-cache openssl

# Copy the Bash script into the container
COPY ssl_check.sh /ssl_check.sh

# Make the script executable
RUN chmod +x /ssl_check.sh

# Command to run
CMD ["/bin/sh", "/ssl_check.sh"]