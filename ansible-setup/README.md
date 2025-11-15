# Ansible

## 1. ✔ Install Ansible
```bash
sudo dnf install ansible
ansible --version
# ansible-lint
sudo dnf install ansible-lint

```

## Testing Ansible Setup
```bash
# test
ansible -i inventory.ini droplet -m ping
# ansible-playbook -i inventory.ini playbook.yml

# run the playbook
ansible-playbook -i inventory.ini create_chris.yml


# test login
ssh -i ~/.ssh/id_ed25519_do chris@167.99.57.214

# firewalld
# run the playbook
ansible-playbook -i inventory.ini firewalld_setup.yml


```

## 3. ✔ Disable root login
```bash
# edit /etc/ssh/sshd_config
sudo sed -i 's/^PermitRootLogin yes/PermitRootLogin no/' /etc/ssh/sshd_config
sudo systemctl restart sshd
```

## 4. ✔ Use a firewall (firewalld or ufw)
```bash
# install firewalld
sudo dnf install firewalld
sudo systemctl enable --now firewalld
```


## Firewalld Ansible
### reload debe hacerse así:

    ansible.builtin.command: firewall-cmd --reload

### o usando systemd:

    ansible.builtin.systemd:
        name: firewalld
        state: reloaded

## 🛠 1. Crear estructura del rol firewall
```bash
# directories
mkdir -p roles/firewall/{tasks,handlers,defaults,meta}
touch roles/firewall/tasks/main.yml
touch roles/firewall/handlers/main.yml
touch roles/firewall/defaults/main.yml
touch roles/firewall/meta/main.yml

# run playbook
ansible-playbook -i inventory.ini firewall_setup.yml
```
