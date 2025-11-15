#!/usr/bin/env bash
set -euo pipefail

# add_do_host.sh
# Usage: ./scripts/add_do_host.sh <alias> [output_name] [workdir]
# Example: ./scripts/add_do_host.sh do-love droplet_ip droplet-do
#
# This script reads a Terraform/OpenTofu output (default `droplet_ip`) using
# the `tofu` CLI in `workdir` (default `droplet-do`), then updates
# ~/.ssh/config by adding or updating a Host entry for the provided alias.

ALIAS=${1:-}
if [ -z "$ALIAS" ]; then
  echo "Usage: $0 <alias> [output_name] [workdir]" >&2
  exit 2
fi

OUTPUT_NAME=${2:-droplet_ip}
WORKDIR=${3:-droplet-do}

SSH_CONFIG="$HOME/.ssh/config"

if ! command -v tofu >/dev/null 2>&1; then
  echo "Error: 'tofu' CLI not found in PATH. Install OpenTofu (tofu) and retry." >&2
  exit 3
fi

get_output_raw() {
  # Try tofu output -raw <name>
  (cd "$WORKDIR" && tofu output -raw "$OUTPUT_NAME") 2>/dev/null || true
}

get_output_json() {
  # Try tofu output -json and jq
  if command -v jq >/dev/null 2>&1; then
    (cd "$WORKDIR" && tofu output -json 2>/dev/null | jq -r ".${OUTPUT_NAME}.value") || true
  else
    # Fallback: try plain `tofu output <name>` and strip quotes
    (cd "$WORKDIR" && tofu output "$OUTPUT_NAME" 2>/dev/null | sed -E 's/^\s*"?([^\"]+)"?\s*$/\1/') || true
  fi
}

IP=""
IP=$(get_output_raw)
if [ -z "$IP" ]; then
  IP=$(get_output_json)
fi

if [ -z "$IP" ]; then
  echo "Error: could not retrieve output '$OUTPUT_NAME' via 'tofu output' in folder '$WORKDIR'" >&2
  exit 4
fi

# Validate IPv4 (basic)
if ! [[ "$IP" =~ ^([0-9]{1,3}\.){3}[0-9]{1,3}$ ]]; then
  echo "Error: output value '$IP' does not look like an IPv4 address" >&2
  exit 5
fi

echo "Got IP for $ALIAS: $IP"

timestamp() { date +%Y%m%d%H%M%S; }

if [ ! -f "$SSH_CONFIG" ]; then
  echo "SSH config not found at $SSH_CONFIG, creating one.";
  mkdir -p "$(dirname "$SSH_CONFIG")"
  touch "$SSH_CONFIG"
  chmod 600 "$SSH_CONFIG"
fi

BACKUP="$SSH_CONFIG.$(timestamp).bak"
cp --preserve=mode,timestamps "$SSH_CONFIG" "$BACKUP"
echo "Backup of ssh config saved to $BACKUP"

TMP=$(mktemp)

# Awk script: if Host <alias> exists, replace or add HostName line inside it.
# This version only writes two lines per host block (Host and HostName) as requested.
awk -v host="$ALIAS" -v ip="$IP" '
  BEGIN { in=0; found=0; hostpat="^Host[[:space:]]+" host "($|[[:space:]])" }
  {
    if ($0 ~ /^Host[[:space:]]+/) {
      # detect start of a Host block
      if (in==1) { in=0 }
      if ($0 ~ hostpat) {
        print $0; in=1; found=1; next
      }
    }
    if (in==1) {
      if ($1 == "HostName") {
        print "  HostName " ip; in=0; next
      }
      # If next Host starts, insert HostName before it
      if ($0 ~ /^Host[[:space:]]+/) {
        print "  HostName " ip
        print $0
        in=0
        next
      }
    }
    print $0
  }
  END {
    if (found==0) {
      print "";
      print "Host " host;
      print "  HostName " ip;
    }
  }
' "$SSH_CONFIG" > "$TMP"

mv "$TMP" "$SSH_CONFIG"
chmod 600 "$SSH_CONFIG"

echo "Updated $SSH_CONFIG with Host $ALIAS -> $IP"
echo "Done. If you want to SSH: ssh $ALIAS"

exit 0
