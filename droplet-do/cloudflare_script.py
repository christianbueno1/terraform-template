import os
import requests

# Load Cloudflare token from environment
CF_API_TOKEN = os.getenv("CF_API_TOKEN")
if not CF_API_TOKEN:
    raise ValueError("Please set the CF_API_TOKEN environment variable")

HEADERS = {
    "Authorization": f"Bearer {CF_API_TOKEN}",
    "Content-Type": "application/json"
}

# 1️⃣ List all zones
zones_resp = requests.get("https://api.cloudflare.com/client/v4/zones", headers=HEADERS)
zones_data = zones_resp.json()

if not zones_data.get("success"):
    raise RuntimeError(f"Failed to fetch zones: {zones_data}")

for zone in zones_data['result']:
    zone_name = zone['name']
    zone_id = zone['id']
    print(f"\nZone: {zone_name} (ID: {zone_id})")

    # 2️⃣ List DNS records for this zone
    dns_resp = requests.get(
        f"https://api.cloudflare.com/client/v4/zones/{zone_id}/dns_records",
        headers=HEADERS
    )
    dns_data = dns_resp.json()

    if not dns_data.get("success"):
        print(f"  Failed to fetch DNS records: {dns_data}")
        continue

    records = dns_data.get("result", [])
    if not records:
        print("  No DNS records found.")
        continue

    for record in records:
        r_type = record.get("type")
        r_name = record.get("name")
        r_content = record.get("content")
        r_ttl = record.get("ttl")
        r_proxied = record.get("proxied", False)
        print(f"  {r_type} {r_name} -> {r_content} TTL:{r_ttl} Proxied:{r_proxied}")
