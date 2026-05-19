# Oracle Cloud IaC Lab

Projet d'infrastructure cloud automatisée avec Terraform et Ansible sur Oracle Cloud Free Tier.

## Objectif

Déployer une infrastructure sécurisée et reproductible :
- VCN segmenté
- bastion public
- VMs privées
- NAT Gateway
- règles réseau strictes
- configuration automatisée avec Ansible

## Stack

- Oracle Cloud Infrastructure
- Terraform
- Ansible
- GitHub Actions
- Ubuntu Server

## Architecture cible

- Subnet public : bastion
- Subnet privé : serveurs applicatifs
- Subnet data : services isolés
- Accès SSH uniquement via bastion

## Déploiement prévu

```bash
cd terraform
terraform init
terraform plan
terraform apply

cd ../ansible
ansible-playbook site.yml

# oracle-cloud-iac-lab

