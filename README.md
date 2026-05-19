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

## Configuration système avec Ansible

Ansible configure automatiquement les serveurs Linux avec plusieurs rôles :

- `common` : paquets de base, timezone, chrony 
- `ssh_hardening` : durcissement SSH 
- `fail2ban` : protection contre les tentatives SSH répétées 
- `firewall` : activation d'un firewall local 
- `node_exporter` : exposition de métriques système pour Prometheus

Lancement :

```bash
cd ansible
ansible-playbook site.yml

---

## Monitoring

Le monitoring est assuré par :

- `node_exporter` sur chaque serveur Linux 
- `Prometheus` sur le bastion 
- `Grafana` sur le bastion

Prometheus collecte les métriques système exposées par `node_exporter`.

Les interfaces web ne sont pas exposées publiquement. L'accès se fait via tunnel SSH :

```bash
ssh -L 9090:127.0.0.1:9090 oci-bastion
ssh -L 3000:127.0.0.1:3000 oci-bastion
```
## Architecture

```mermaid
flowchart TD
    User["Poste local WSL2<br/>Terraform / Ansible / SSH"] -->|SSH| Bastion["Bastion public<br/>Ubuntu<br/>Subnet public 10.0.1.0/24"]

    Bastion -->|SSH ProxyJump| App["VM applicative privée<br/>Ubuntu<br/>Subnet privé 10.0.10.0/24"]

    Bastion --> Prometheus["Prometheus<br/>127.0.0.1:9090"]
    Bastion --> Grafana["Grafana<br/>127.0.0.1:3000"]
    Bastion --> NodeBastion["node_exporter<br/>9100"]

    Prometheus -->|Scrape 9100| NodeBastion
    Prometheus -->|Scrape 9100<br/>réseau privé| NodeApp["node_exporter<br/>VM app : 9100"]

    App --> NodeApp

    subgraph OCI["Oracle Cloud Infrastructure"]
        subgraph VCN["VCN 10.0.0.0/16"]
            subgraph PublicSubnet["Subnet public / DMZ"]
                Bastion
                Prometheus
                Grafana
                NodeBastion
            end

            subgraph PrivateSubnet["Subnet privé"]
                App
                NodeApp
            end

            subgraph DataSubnet["Subnet data 10.0.20.0/24"]
                Data["Zone data isolée<br/>prévue pour DB / stockage"]
            end
        end
    end

    Internet["Internet"] -->|SSH depuis IP admin uniquement| Bastion
    User -->|Tunnel SSH<br/>localhost:9090 / localhost:3000| Bastion
