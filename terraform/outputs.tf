output "vcn_id" {
  description = "OCID du VCN"
  value       = oci_core_vcn.main.id
}

output "public_subnet_id" {
  description = "OCID du subnet public"
  value       = oci_core_subnet.public.id
}

output "private_subnet_id" {
  description = "OCID du subnet privé"
  value       = oci_core_subnet.private.id
}

output "data_subnet_id" {
  description = "OCID du subnet data"
  value       = oci_core_subnet.data.id
}

output "internet_gateway_id" {
  description = "OCID de l'Internet Gateway"
  value       = oci_core_internet_gateway.main.id
}

output "nat_gateway_id" {
  description = "OCID de la NAT Gateway"
  value       = oci_core_nat_gateway.main.id
}

output "service_gateway_id" {
  description = "OCID de la Service Gateway"
  value       = oci_core_service_gateway.main.id
}
output "bastion_public_ip" {
  description = "IP publique du bastion"
  value       = oci_core_instance.bastion.public_ip
}

output "bastion_private_ip" {
  description = "IP privée du bastion"
  value       = oci_core_instance.bastion.private_ip
}

output "app_private_ips" {
  description = "IPs privées des VMs applicatives"
  value       = [for instance in oci_core_instance.app : instance.private_ip]
}

output "ssh_bastion_command" {
  description = "Commande SSH pour se connecter au bastion"
  value       = "ssh -i ~/.ssh/oracle_iac_lab ubuntu@${oci_core_instance.bastion.public_ip}"
}

output "ssh_app_via_bastion_example" {
  description = "Exemple de connexion SSH vers la première VM privée via bastion"
  value       = "ssh -i ~/.ssh/oracle_iac_lab -J ubuntu@${oci_core_instance.bastion.public_ip} ubuntu@${oci_core_instance.app[0].private_ip}"
}
