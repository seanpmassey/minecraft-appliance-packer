#!/bin/bash -eux

##
## Debian system
## Install system utilities
##

echo '> Installing System Utilities...'

apt-get install -y \
  jq \
  grc \
  git \
  tmux \
  htop \
  unzip \
  ufw \
  less \
  logrotate \
  original-awk

echo '> Done'

echo '> Configure UFW Firewall...'
ufw allow ssh
ufw enable

echo '> Done'

##
## Debian system
## Install PowerShell
##

echo '> Installing PowerShell Prerequisites...'

apt-get install -y \
  apt-transport-https \
  gnupg

echo '> Done'

echo '> Configure Microsoft PowerShell Apt Repository...'

wget -O - https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -
echo "deb [arch=amd64] https://packages.microsoft.com/repos/microsoft-debian-bullseye-prod bullseye main" > /etc/apt/sources.list.d/microsoft.list

echo '> Update Apt Sources and Install PowerShell...'
apt-get update
apt-get install -y powershell

echo '> Done'

##
## Debian system
## Configure Temurin OpenJDK Repo
##

echo '> Configure Adoptium Temurin OpenJDK Repo...'

mkdir -p /etc/apt/keyrings
wget -O - https://packages.adoptium.net/artifactory/api/gpg/key/public | tee /etc/apt/keyrings/adoptium.asc
echo "deb [signed-by=/etc/apt/keyrings/adoptium.asc] https://packages.adoptium.net/artifactory/deb $(awk -F= '/^VERSION_CODENAME/{print$2}' /etc/os-release) main" | tee /etc/apt/sources.list.d/adoptium.list

apt-get update

echo '> Done'