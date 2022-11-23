
variable "appliance_template_path" {
  type    = string
  default = "Path to folder where the OVA Template file is stored"
}

variable "cluster" {
  type    = string
  default = "Cluster-Workload"
}

variable "datastore_iso" {
  type    = string
  default = "ISO"
}

variable "datastore_vm" {
  type    = string
  default = "NFS"
}

variable "description" {
  type    = string
  default = "Debian Server Template"
}

variable "folder" {
  type    = string
  default = "Templates/Appliances"
}

variable "iso_name" {
  type    = string
  default = "debian-11.5.0-amd64-netinst.iso"
}

variable "network" {
  type    = string
  default = "Your Network Here"
}

variable "output_directory" {
  type    = string
  default = "Your Output directory here"
}

variable "password" {
  type      = string
  default   = "Correct Horse Battery Staple"
  sensitive = true
}

variable "photon_ovf_template" {
  type    = string
  default = "appliance.xml.template"
}

variable "ssh_password" {
  type      = string
  default   = "Correct Horse Battery Staple"
  sensitive = true
}

variable "ssh_username" {
  type    = string
  default = "root"
}

variable "username" {
  type    = string
  default = "vCenter User"
}

variable "vcenter_server" {
  type    = string
  default = "vCenter FQDN"
}

variable "version" {
  type    = string
  default = "11.05"
}