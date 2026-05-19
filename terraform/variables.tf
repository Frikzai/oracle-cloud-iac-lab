variable "tenancy_ocid" {
  description = "OCID du tenancy Oracle Cloud"
  type        = string
  sensitive   = true
}

variable "user_ocid" {
  description = "OCID de l'utilisateur Oracle Cloud"
  type        = string
  sensitive   = true
}

variable "fingerprint" {
  description = "Fingerprint de la clé API OCI"
  type        = string
  sensitive   = true
}

variable "private_key_path" {
  description = "Chemin vers la clé privée API OCI"
  type        = string
  sensitive   = true
}

variable "region" {
  description = "Région Oracle Cloud"
  type        = string
}

variable "compartment_ocid" {
  description = "OCID du compartment où créer les ressources"
  type        = string
}

variable "project_name" {
  description = "Nom du projet"
  type        = string
  default     = "oracle-iac-lab"
}

variable "environment" {
  description = "Environnement du projet"
  type        = string
  default     = "dev"
}

variable "vcn_cidr" {
  description = "CIDR du VCN"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "CIDR du subnet public"
  type        = string
  default     = "10.0.1.0/24"
}

variable "private_subnet_cidr" {
  description = "CIDR du subnet privé applicatif"
  type        = string
  default     = "10.0.10.0/24"
}

variable "data_subnet_cidr" {
  description = "CIDR du subnet data"
  type        = string
  default     = "10.0.20.0/24"
}
