```bash
# Ahora que el puerto de n8n (5678) está abierto en el firewall, deberías poder:
nc -zv 167.99.57.214 5678
curl -I http://167.99.57.214:5678


## next
El siguiente paso natural ahora sería crear el rol Ansible para n8n, que automatice:
Crear el pod n8n-pod
Levantar PostgreSQL y n8n dentro del pod
Montar volúmenes persistentes
Configurar todas las variables de entorno
Abrir automáticamente los puertos necesarios en el firewall
Si quieres, puedo escribir el playbook y el rol completo listo para usar, para que despliegues n8n con un solo comando.