# Oracle Cloud IaC Lab

Projet d'infrastructure cloud automatisée sur **Oracle Cloud Infrastructure Free Tier** avec **Terraform**.

L'objectif est de créer une infrastructure cloud propre, segmentée et reproductible, sans configuration manuelle dans la console Oracle Cloud.

---

## Objectif du projet

Ce projet vise à déployer automatiquement une infrastructure de type système/réseau comprenant :

- un réseau cloud privé OCI ;
- une segmentation réseau public / privé / data ;
- un bastion d'administration exposé uniquement en SSH ;
- une ou plusieurs VMs applicatives privées sans IP publique ;
- des règles de sécurité restrictives ;
- une base prête pour une future automatisation Ansible.

L'idée est de démontrer des compétences concrètes en :

- Infrastructure as Code ;
- administration système Linux ;
- réseau cloud ;
- sécurité réseau ;
- automatisation ;
- bonnes pratiques Git.

---

## Stack technique

- Oracle Cloud Infrastructure
- Terraform
- Ubuntu Server
- Git / GitHub
- WSL2 Ubuntu pour l'environnement local
- SSH avec clé privée/publique

---

## Architecture cible

```text
Internet
   |
   | SSH autorisé uniquement depuis l'IP admin
   |
[Internet Gateway]
   |
[Subnet public / DMZ]
   |
[Bastion]
   |
   | SSH via ProxyJump
   |
[Subnet privé]
   |
[VM applicative privée]

[Subnet data]
   |
[Ressources isolées futures]
