#!/usr/bin/env bash
set -euo pipefail

PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TERRAFORM_DIR="${PROJECT_ROOT}/terraform"
ANSIBLE_DIR="${PROJECT_ROOT}/ansible"

BASTION_IP="$(cd "${TERRAFORM_DIR}" && terraform output -raw bastion_public_ip)"
APP_IP="$(cd "${TERRAFORM_DIR}" && terraform output -json app_private_ips | jq -r '.[0]')"

mkdir -p "${ANSIBLE_DIR}/inventory"

cat > "${ANSIBLE_DIR}/inventory/terraform.yml" <<EOF
---
all:
  children:
    bastion:
      hosts:
        oci-bastion:

    app:
      hosts:
        oci-app-1:

    linux:
      children:
        bastion:
        app:
EOF

mkdir -p /home/shaizo/.ssh

cat > /home/shaizo/.ssh/config <<EOF
Host oci-bastion
    HostName ${BASTION_IP}
    User ubuntu
    IdentityFile /home/shaizo/.ssh/oracle_iac_lab
    IdentitiesOnly yes
    StrictHostKeyChecking no

Host oci-app-1
    HostName ${APP_IP}
    User ubuntu
    IdentityFile /home/shaizo/.ssh/oracle_iac_lab
    IdentitiesOnly yes
    ProxyJump oci-bastion
    StrictHostKeyChecking no
EOF

chmod 700 /home/shaizo/.ssh
chmod 600 /home/shaizo/.ssh/config
chmod 600 /home/shaizo/.ssh/oracle_iac_lab

echo "Inventaire Ansible généré : ${ANSIBLE_DIR}/inventory/terraform.yml"
echo "Config SSH générée : /home/shaizo/.ssh/config"
echo "Bastion : ${BASTION_IP}"
echo "App     : ${APP_IP}"
