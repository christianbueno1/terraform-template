#!/bin/bash
# Cloudflare DNS listing script
# Requirements: curl, jq
# Usage: CF_API_TOKEN="your_token_here" ./cf_list_domains.sh

# Check for API token
if [ -z "$CF_API_TOKEN" ]; then
    echo "Error: Please set your CF_API_TOKEN environment variable."
    exit 1
fi

echo "Fetching Cloudflare zones..."

# Get all zones
zones=$(curl -s -X GET "https://api.cloudflare.com/client/v4/zones" \
    -H "Authorization: Bearer $CF_API_TOKEN" \
    -H "Content-Type: application/json" | jq -r '.result[] | "\(.id) \(.name)"')

if [ -z "$zones" ]; then
    echo "No zones found or invalid API token."
    exit 1
fi

# Loop through each zone and list DNS records
while read -r zone_id zone_name; do
    echo -e "\nDomain: $zone_name (Zone ID: $zone_id)"
    echo "----------------------------------------"
    
    # Get DNS records for this zone
    records=$(curl -s -X GET "https://api.cloudflare.com/client/v4/zones/$zone_id/dns_records" \
        -H "Authorization: Bearer $CF_API_TOKEN" \
        -H "Content-Type: application/json" | jq -r '.result[] | "\(.type) \(.name) -> \(.content)"')

    if [ -z "$records" ]; then
        echo "No DNS records found."
    else
        echo "$records"
    fi
done <<< "$zones"
