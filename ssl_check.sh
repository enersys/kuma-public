#!/bin/bash

URL="enersys.co.th"  # URL without 'https://' or 'http://'
TEST_URL="google.co.th"
LOG_FILE="/var/log/ssl-check.log"  # Path to log file

# Get SSL certificate expiration date using OpenSSL and SNI (Server Name Indication)
expiry_date=$(echo | openssl s_client -servername "$URL" -connect "$URL:443" 2>/dev/null | openssl x509 -noout -enddate | sed 's/notAfter=//')
expiry_date_test=$(echo | openssl s_client -servername "$TEST_URL" -connect "$TEST_URL:443" 2>/dev/null | openssl x509 -noout -enddate | sed 's/notAfter=//')

# Logging only the relevant information
{
    if [ -z "$expiry_date" ]; then
        echo "Could not retrieve SSL certificate for $URL"
    else
        echo "SSL certificate for https://$URL expires on: $expiry_date"
    fi

    if [ -z "$expiry_date_test" ]; then
        echo "Could not retrieve SSL certificate for $TEST_URL"
    else
        echo "SSL certificate for https://$TEST_URL expires on: $expiry_date_test"
    fi
} >> "$LOG_FILE"