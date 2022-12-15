#!/bin/bash -eux

##
## Debian system
## Install system utilities
##

echo '> Installing System Utilities...'

yes | apt-get install -y \
  jq \
  grc \
  git \
  tmux \
  htop \
  unzip \
  apt-transport-https \
  gnupg \
  ufw \
  less \
  logrotate \
  original-awk

echo '> Done'

echo '> Configure UFW Firewall...'
ufw allow ssh
ufw enable

echo '> Done'
