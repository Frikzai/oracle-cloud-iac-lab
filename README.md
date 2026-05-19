# Oracle Cloud IaC Lab

Projet d'infrastructure cloud automatisée sur **Oracle Cloud Infrastructure Free Tier**, réalisé avec **Terraform** et **Ansible**.

L'objectif est de déployer une infrastructure cloud complète, sécurisée et reproductible, sans configuration manuelle dans la console Oracle Cloud.

Ce projet met en avant des compétences en :

- administration système Linux 
- réseau cloud 
- Infrastructure as Code 
- automatisation 
- sécurité SSH 
- gestion d'un bastion 
- Ansible 
- Git et documentation technique.

---

## Objectif du projet

L'objectif est de créer une infrastructure cloud de type système/réseau comprenant :

- un réseau cloud privé Oracle Cloud 
- une segmentation réseau public / privé / data 
- un bastion public pour l'administration 
- une VM applicative privée sans IP publique 
- des règles de sécurité restrictives 
- un accès SSH sécurisé via bastion 
- un inventaire Ansible fonctionnel 
- une base prête pour du hardening système et du monitoring.

L'infrastructure est conçue pour être :

- versionnée 
- reproductible 
- modifiable 
- destructible 
- documentée

---

## Stack technique

- Oracle Cloud Infrastructure
- Oracle Cloud Free Tier
- Terraform
- Ansible
- Ubuntu Server
- Git / GitHub
- WSL2 Ubuntu
- SSH
- ProxyJump

---

## Architecture globale

```text
Poste local WSL2
   |
   | Terraform / Ansible / SSH
   |
   v
Oracle Cloud Infrastructure
   |
   +-- VCN 10.0.0.0/16
       |
       +-- Subnet public 10.0.1.0/24
       |   |
       |   +-- Bastion public
       |
       +-- Subnet privé 10.0.10.0/24
       |   |
       |   +-- VM applicative privée
       |
       +-- Subnet data 10.0.20.0/24
           |
           +-- Ressources isolées futures

## Structure du projet

```text
oracle-cloud-iac-lab/
├── README.md
├── .gitignore
├── terraform/
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   ├── network.tf
│   ├── security.tf
│   ├── compute.tf
│   ├── terraform.tfvars.example
│   └── terraform.tfvars
├── ansible/
│   ├── ansible.cfg
│   ├── inventory/
│   │   ├── terraform.yml
│   │   └── oracle.oci.yml
│   ├── group_vars/
│   │   └── all.yml
│   └── site.yml
├── scripts/
│   └── generate_ansible_access.sh
├── docs/
│   └── adr/
└── .github/
    └── workflows/
