#!/bin/bash -eux

##
## Create Minecraft Groups and Users
##

echo '>Create Minecraft user account'
useradd -r -U -s /bin/bash minecraft

echo '>Create Minecraft service group'
groupadd minecraft-admins
usermod -a -G minecraft-admins root
usermod -a -G minecraft-admins minecraft

##
## Minecraft Folder Configuration
##

echo '> Create Minecraft Directories'
echo "Create binary directory: /opt/Minecraft/bin"
mkdir -p /opt/Minecraft/bin

echo "Create Scripts Directory: /opt/Minecraft/scripts"
mkdir /opt/Minecraft/scripts

echo "Create Tools Directories: /opt/Minecraft/tools"
mkdir -p /opt/Minecraft/tools/mcrcon

echo "Create Tools Directories: /opt/Minecraft/backups"
mkdir /opt/Minecraft/backups

##
## Minecraft Tools Download and configure - mcrcon
##

echo '>Downloading mcrcon package'
wget https://github.com/Tiiffi/mcrcon/releases/download/v0.7.1/mcrcon-0.7.1-linux-x86-64.tar.gz -P /opt/Minecraft/tools/tmp

echo '>Untar mcrcon package'
tar -C /opt/Minecraft/tools/tmp -zxvf /opt/Minecraft/tools/tmp/mcrcon-0.7.1-linux-x86-64.tar.gz

echo '>Copy mcrcon binary to Tools/mcrcon folder'
cp /opt/Minecraft/tools/tmp/mcrcon-0.7.1-linux-x86-64/mcrcon /opt/Minecraft/tools/mcrcon

echo '>Set executable bit on mcrcon'
chmod -vR 755 /opt/Minecraft/tools/mcrcon

echo '>Remove tmp folder and downloaded mcrcon files'
rm -rf /opt/Minecraft/tools/tmp/
