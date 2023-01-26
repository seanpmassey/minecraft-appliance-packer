#!/bin/bash -eux

##
## Debian Settings
## Misc configuration
##

echo '> Debian Settings...'

echo '> Installing resolvconf...'
apt-get install -y resolvconf-admin
echo "nameserver 8.8.8.8" > /etc/resolv.conf
echo ""

echo '> SSH directory'
mkdir -vp $HOME/.ssh

echo '> Disable IPv6'
echo "net.ipv6.conf.all.disable_ipv6 = 1" >> /etc/sysctl.conf

echo '> Setup Appliance Banner for /etc/issue & /etc/issue.net'
echo ">>" | tee /etc/issue /etc/issue.net > /dev/null
echo ">> Debian vSphere Appliance $(cat /etc/debian_version)" | tee -a /etc/issue /etc/issue.net > /dev/null
echo ">>" | tee -a /etc/issue /etc/issue.net > /dev/null
sed -i 's/#Banner none/Banner \/etc\/issue.net/g' /etc/ssh/sshd_config

echo '> Enable rc.local facility for debian-init.py'
cat << EOF > /etc/rc.local
#!/bin/sh -e
#
# rc.local
#
# This script is executed at the end of each multiuser runlevel.
# Make sure that the script will "exit 0" on success or any other
# value on error.
#
# In order to enable or disable this script just change the execution
# bits.
#
# By default this script does nothing.

if [ ! -f /etc/debian.config ]; then
    /sbin/debian-init.py
    /sbin/debian-regeneratesshkeys.sh
    echo "\$(date)" > /etc/debian.config
fi

if [ ! -f /etc/minecraft.config ]; then
    /sbin/debian-minecraftinstall.sh
    echo "\$(date)" > /etc/minecraft.config
fi

exit 0
EOF
chmod +x /etc/rc.local
systemctl daemon-reload

echo '> Done'