output "instance_id" {
  description = "OCID of the OCI Compute instance."
  value       = oci_core_instance.ollama.id
}

output "instance_name" {
  description = "Display name of the OCI Compute instance."
  value       = oci_core_instance.ollama.display_name
}

output "public_ip" {
  description = "Public IPv4 address assigned to the instance."
  value       = oci_core_instance.ollama.public_ip
}

output "private_ip" {
  description = "Private IPv4 address assigned to the instance."
  value       = oci_core_instance.ollama.private_ip
}
