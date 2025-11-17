#!/usr/bin/env bash
# create-cloudflare-dns.sh

# how to test.
# Define these variables for testing purposes
# DROPLET_IP=$(terraform output -raw droplet_ip)
# use the cloudflare api to get the zone id for your domain
# ZONE_ID="tu_zone_id_aqui"
# RECORD_NAME="n8nai"
#
# ./create-cloudflare-dns.sh "$ZONE_ID" "$RECORD_NAME" "$DROPLET_IP"
# ./create-cloudflare-dns.sh $ZONE_ID n8nai $DROPLET_IP

# Inputs (puedes usar outputs de Terraform)
ZONE_ID="$1"          # ID de tu zona Cloudflare
RECORD_NAME="$2"      # por ejemplo n8nai, n8nexus, flowbot
RECORD_IP="$3"        # IP del droplet
API_TOKEN="$CF_API_TOKEN" # Token Cloudflare

# for test print values
echo "ZONE_ID: $ZONE_ID"
echo "RECORD_NAME: $RECORD_NAME"
echo "RECORD_IP: $RECORD_IP"

if [[ -z "$ZONE_ID" || -z "$RECORD_NAME" || -z "$RECORD_IP" ]]; then
  echo "Uso: $0 ZONE_ID RECORD_NAME RECORD_IP"
  exit 1
fi

# Crear registro A
response=$(curl -s -X POST "https://api.cloudflare.com/client/v4/zones/${ZONE_ID}/dns_records" \
  -H "Authorization: Bearer $API_TOKEN" \
  -H "Content-Type: application/json" \
  --data '{
    "type": "A",
    "name": "'"$RECORD_NAME"'",
    "content": "'"$RECORD_IP"'",
    "ttl": 1,
    "proxied": false
  }')

# Mostrar resultado
echo "Resultado de Cloudflare API:"
echo "$response"
