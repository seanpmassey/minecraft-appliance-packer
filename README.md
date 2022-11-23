# packer-vSphere-Minecraft-Debian-Appliance
 Packer Files for a Debian-based Minecraft vSphere virtual appliance.

 All Minecraft binaries, tools, and scripts are located in /opt/Minecraft.

Tools included:
* MCRCON: /opt/Minecraft/tools/mcrcon
* PowerShell
* JDK 1.17 provided by the Adoptium Temurin project

Minecraft can be configured pre-deployment using OVF properties. The values entered when deploying the appliance will entered into the server.properties file during the appliance customization phase during the first boot.  This is also when Minecraft will be downloaded from Mojang and installed.  All of the other Minecraft prerequisites are installed when the appliance is built.

The appliance will automatically check for new system and Minecraft updates using a CRON job.  The Minecraft updater is a PowerShell script called Upgrade-MinecraftService.ps1. This script is located in /opt/Minecraft/scripts.  The script checks the current version of the Minecraft server by reading the minecraft.properties file and checks for the latest stable release in the Minecraft version manifest file located at "https://launchermeta.mojang.com/mc/game/version_manifest.json." If there is a newer version available and the switch to apply updates is enabled, the newest version of the server file will be downloaded and installed.

## Getting Started

To use this template, update the values in the debian.auto.pkrvars.hcl file to match your environment.  Then run the build-minecraft.sh script to start the build process.

Notes:
There is a variable called appliance_template_path.  This is the path to the folder where the postprocess-ova-properties files are located.  This needs to be coded in for now because it wouldn't work properly in my CICD pipeline if I did not include the full path.  At some point, I will be fixing this using the CWD Packer variable.

Ackowledgements:  Thank you to Timo Sugliani and William Lam as this was based off of work they had done previously around Debian Packer templates and adding OVF properties to OVA files.  
