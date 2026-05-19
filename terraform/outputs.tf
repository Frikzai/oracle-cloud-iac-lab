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
