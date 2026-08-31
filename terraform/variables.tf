variable "tenancy_ocid" {
  description = "OCID of the OCI tenancy."
  type        = string
}

#variable "user_ocid" {
#  description = "OCID of the OCI user used by Terraform."
#  type        = string
#}

#variable "fingerprint" {
#  description = "Fingerprint of the OCI API signing key."
#  type        = string
#}

#variable "private_key_path" {
#  description = "Local path to the OCI API signing private key."
#  type        = string
#}

variable "region" {
  description = "OCI region where the resources will be created."
  type        = string
  default     = "sa-saopaulo-1"
}

variable "compartment_ocid" {
  description = "OCID of the compartment where the Compute instance will be created."
  type        = string
}

variable "instance_name" {
  description = "Display name of the OCI Compute instance."
  type        = string
  default     = "ollama-on-oci"
}

variable "shape" {
  description = "OCI Compute shape."
  type        = string
  default     = "VM.Standard.A1.Flex"
}

variable "ocpus" {
  description = "Number of OCPUs assigned to the instance."
  type        = number
  default     = 2
}

variable "memory_in_gbs" {
  description = "Amount of memory assigned to the instance in GB."
  type        = number
  default     = 12
}

variable "boot_volume_size_in_gbs" {
  description = "Boot volume size in GB."
  type        = number
  default     = 50
}

variable "ssh_public_key_path" {
  description = "Local path to the SSH public key installed on the Compute instance."
  type        = string
}

variable "assign_public_ip" {
  description = "Whether a public IPv4 address should be assigned to the instance."
  type        = bool
  default     = true
}

variable "ssh_ingress_cidr" {
  description = "CIDR allowed to access SSH port 22."
  type        = string
}

variable "https_ingress_cidr" {
  description = "CIDR allowed to access HTTPS port 443."
  type        = string
}

variable "ollama_model" {
  description = "Ollama model to be installed by Ansible."
  type        = string
  default     = "qwen3:4b"
}
variable "operating_system" {
  description = "Operating system used by the Compute instance."
  type        = string
  default     = "Oracle Linux"
}

variable "operating_system_version" {
  description = "Oracle Linux major version."
  type        = string
  default     = "9"
}
