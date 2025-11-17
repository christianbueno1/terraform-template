# n8n install using podman on fedora linux 42.

```bash
# 🧱 1. Crear una red Podman dedicada
podman network create n8n-net


# 📦 2. Crear volúmenes persistentes
podman volume create n8n_data
podman volume create n8n_pgdata

# 🐘 3. Crear el Pod para PostgreSQL
podman pod create \
  --name n8n-postgres-pod \
  --network n8n-net

# Crear contenedor PostgreSQL dentro de su pod:
podman run -d \
  --name n8n-postgres \
  --pod n8n-postgres-pod \
  -e POSTGRES_DB=n8n \
  -e POSTGRES_USER=n8n \
  -e POSTGRES_PASSWORD="maGazine1!" \
  -v n8n_pgdata:/var/lib/postgresql \
  docker.io/postgres:18.1-trixie

# 🔧 4. Crear el Pod para n8n
podman pod create \
  --name n8n-pod \
  --network n8n-net \
  -p 5678:5678


# Crear contenedor n8n dentro de su pod:
podman run -d \
  --name n8n \
  --pod n8n-pod \
  -e GENERIC_TIMEZONE="America/Guayaquil" \
  -e TZ="America/Guayaquil" \
  -e N8N_ENFORCE_SETTINGS_FILE_PERMISSIONS=true \
  -e N8N_RUNNERS_ENABLED=true \
  -e N8N_BLOCK_ENV_ACCESS_IN_NODE=false \
  -e N8N_GIT_NODE_DISABLE_BARE_REPOS=true \
  -e DB_TYPE=postgresdb \
  -e DB_POSTGRESDB_DATABASE=n8n \
  -e DB_POSTGRESDB_HOST=n8n-postgres-pod \
  -e DB_POSTGRESDB_PORT=5432 \
  -e DB_POSTGRESDB_USER=n8n \
  -e DB_POSTGRESDB_SCHEMA=public \
  -e DB_POSTGRESDB_PASSWORD="maGazine1!" \
  -v n8n_data:/home/node/.n8n \
  docker.n8n.io/n8nio/n8n

```


## posrt forwading
```bash
ssh -L 5678:localhost:5678 usuario@167.99.57.214
# or use the host alias do-joy
ssh -L 5678:localhost:5678 do-joy

# Luego, en tu navegador local:
http://localhost:5678
```
