#!/usr/bin/env bash

# Usage: ./update-inventory-ip.sh NEW_IP
# Example: ./update-inventory-ip.sh 192.168.1.10

set -e

# FILE="ansible-setup/inventory.ini"
FILE="inventory.ini"

if [ -z "$1" ]; then
    echo "❌ Error: Missing IP argument."
    echo "Usage: $0 NEW_IP"
    exit 1
fi

NEW_IP="$1"

if [[ ! -f "$FILE" ]]; then
    echo "❌ Error: $FILE does not exist."
    exit 1
fi

# Update only the line under [droplet] that starts with an IP address
sed -i "/^\[droplet\]/ {n; s/^[0-9.]\+/$NEW_IP/}" "$FILE"

echo "✅ Inventory updated successfully!"
echo "➡️  New content:"
cat "$FILE"
