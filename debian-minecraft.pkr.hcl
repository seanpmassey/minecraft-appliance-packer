packer {
  required_version = " >= 1.8.0 "
  required_plugins {
    vsphere = {
      version = " >= 1.0.6 "
      source  = "github.com/hashicorp/vsphere"
    }
  }
}

locals{
    build_version     = formatdate("YYMM", timestamp())
    minecraft_vm_name = "Debian-Minecraft-${local.build_version}"
    build_date        = formatdate("MM-DD-YYYY", timestamp())
}

source "vsphere-iso" "debian-minecraft" {
  CPUs                 = 2
  RAM                  = 6144
  boot_command         = ["<wait3s>c<wait3s>", "set background_color=black <wait>", "<enter><wait>", "linux /install.amd/vmlinuz <wait>", "vga=788 <wait>", "auto=true preseed/url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/preseed.cfg <wait>", "ipv6.disable=1 language=en <wait>", "debian-installer=en_US <wait>", "biosdevname=0 <wait>", "locale=en_US <wait>", "kbd-chooser/method=us <wait>", "keyboard-configuration/xkb-keymap=us <wait>", "netcfg/get_hostname=${local.minecraft_vm_name} <wait>", "netcfg/get_domain=lan.seanmassey.net <wait>", "fb=false <wait>", "debconf/frontend=noninteractive <wait>", "console-setup/ask_detect=false <wait>", "console-keymaps-at/keymap=us <wait>", "<enter><wait>", "initrd /install.amd/initrd.gz <enter><wait>", "boot <enter>"]
  boot_order           = "disk,cdrom"
  boot_wait            = "10s"
  cluster              = "${var.cluster}"
  communicator         = "ssh"
  convert_to_template  = false
  create_snapshot      = false
  datastore            = "${var.datastore_vm}"
  disk_controller_type = ["pvscsi"]
  export {
    force            = true
    image_files      = false
    options          = ["nodevicesubtypes"]
    output_directory = "${var.output_directory}/${local.minecraft_vm_name}"
  }
  firmware            = "efi"
  folder              = "${var.folder}"
  guest_os_type       = "debian11_64Guest"
  http_directory      = "http/"
  insecure_connection = true
  iso_paths           = ["[${var.datastore_iso}]/Linux/Debian/${var.iso_name}"]
  network_adapters {
    network      = "${var.network}"
    network_card = "vmxnet3"
  }
  notes            = "Base OS, VMware Tools, Minecraft Setup, patched up to ${local.build_date}"
  password         = "${var.password}"
  remove_cdrom     = true
  shutdown_command = "/sbin/shutdown -h now"
  shutdown_timeout = "1000s"
  ssh_password     = "${var.ssh_password}"
  ssh_username     = "${var.ssh_username}"
  storage {
    disk_size             = 32768
    disk_thin_provisioned = true
  }
  username       = "${var.username}"
  vcenter_server = "${var.vcenter_server}"
  vm_name        = "${local.minecraft_vm_name}"
  vm_version     = 19
}

build {
  sources = ["source.vsphere-iso.debian-minecraft"]

  provisioner "file" {
    destination = "/root/.bash_profile"
    source      = "files/bash_profile.sh"
  }

  provisioner "file" {
    destination = "/root/.bash_prompt"
    source      = "files/bash_prompt.sh"
  }

  provisioner "file" {
    destination = "/sbin/debian-init.py"
    source      = "files/debian-init.py"
  }

  provisioner "shell" {
    environment_vars = ["DEBIAN_FRONTEND=noninteractive"]
    scripts          = ["scripts/debian-update.sh", "scripts/debian-system.sh", "scripts/debian-vmware.sh", "scripts/debian-minecraftsetup.sh", "scripts/debian-minecraftsettings.sh"]
  }

  provisioner "file" {
    destination = "/opt/Minecraft/scripts/Get-MinecraftServer.ps1"
    source      = "files/Get-MinecraftServer.ps1"
  }

  provisioner "file" {
    destination = "/opt/Minecraft/scripts/Upgrade-MinecraftService.ps1"
    source      = "files/Upgrade-MinecraftService.ps1"
  }

  provisioner "file" {
    destination = "/etc/systemd/system/minecraft.service"
    source      = "files/minecraft.service"
  }

  provisioner "file" {
    destination = "/sbin/debian-regeneratesshkeys.sh"
    source      = "files/debian-regeneratesshkeys.sh"
  }

  provisioner "file" {
    destination = "/sbin/debian-minecraftinstall.sh"
    source      = "files/debian-minecraftinstall.sh"
  }

  provisioner "shell" {
    scripts = ["scripts/debian-cleanup.sh"]
  }

  post-processor "shell-local" {
    environment_vars = ["APPLIANCE_NAME=${local.minecraft_vm_name}", "APPLIANCE_VERSION=${var.version}", "APPLIANCE_OVA=${local.minecraft_vm_name}_${var.version}", "OUTPUT_DIRECTORY=${var.output_directory}"]
    inline           = ["cp ${var.appliance_template_path}/${var.photon_ovf_template} ${var.output_directory}/${local.minecraft_vm_name}/", "./postprocess-ova-properties/add_ovf_properties.sh"]
  }
}
