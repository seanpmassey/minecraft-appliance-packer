#!/bin/bash -eux

##
## Retrieve Variables
##
    MINECRAFT_VERSION=$(vmtoolsd --cmd "info-get guestinfo.ovfEnv" | grep "guestinfo.minecraft.version") 
    MINECRAFT_SERVERPORT=$(vmtoolsd --cmd "info-get guestinfo.ovfEnv" | grep "guestinfo.minecraft.serverport")
    MINECRAFT_ENABLERCON=$(vmtoolsd --cmd "info-get guestinfo.ovfEnv" | grep "guestinfo.minecraft.enablercon")
    MINECRAFT_RCONPORT=$(vmtoolsd --cmd "info-get guestinfo.ovfEnv" | grep "guestinfo.minecraft.rconport")
    MINECRAFT_RCONPASSWORD=$(vmtoolsd --cmd "info-get guestinfo.ovfEnv" | grep "guestinfo.minecraft.rconpassword")
    MINECRAFT_ONLINEMODE=$(vmtoolsd --cmd "info-get guestinfo.ovfEnv" | grep "guestinfo.minecraft.onlinemode")
    MINECRAFT_GAMEMODE=$(vmtoolsd --cmd "info-get guestinfo.ovfEnv" | grep "guestinfo.minecraft.gamemode")
    MINECRAFT_DIFFICULTY=$(vmtoolsd --cmd "info-get guestinfo.ovfEnv" | grep "guestinfo.minecraft.difficulty")
    MINECRAFT_LEVELNAME=$(vmtoolsd --cmd "info-get guestinfo.ovfEnv" | grep "guestinfo.minecraft.levelname")
    MINECRAFT_LEVELSEED=$(vmtoolsd --cmd "info-get guestinfo.ovfEnv" | grep "guestinfo.minecraft.levelseed")
    MINECRAFT_LEVELTYPE=$(vmtoolsd --cmd "info-get guestinfo.ovfEnv" | grep "guestinfo.minecraft.leveltype")
    MINECRAFT_MAXWORLDSIZE=$(vmtoolsd --cmd "info-get guestinfo.ovfEnv" | grep "guestinfo.minecraft.maxworldsize")
    MINECRAFT_MAXPLAYERS=$(vmtoolsd --cmd "info-get guestinfo.ovfEnv" | grep "guestinfo.minecraft.maxplayers")
    MINECRAFT_ALLOWNETHER=$(vmtoolsd --cmd "info-get guestinfo.ovfEnv" | grep "guestinfo.minecraft.allownether")
    MINECRAFT_GENERATESTRUCTURES=$(vmtoolsd --cmd "info-get guestinfo.ovfEnv" | grep "guestinfo.minecraft.generatestructures")
    MINECRAFT_SPAWNANIMALS=$(vmtoolsd --cmd "info-get guestinfo.ovfEnv" | grep "guestinfo.minecraft.spawnanimals")
    MINECRAFT_SPAWNMONSTERS=$(vmtoolsd --cmd "info-get guestinfo.ovfEnv" | grep "guestinfo.minecraft.spawnmonsters")
    MINECRAFT_SPAWNNPCS=$(vmtoolsd --cmd "info-get guestinfo.ovfEnv" | grep "guestinfo.minecraft.spawnnpcs")
    #MINECRAFT_PVP=$(vmtoolsd --cmd "info-get guestinfo.ovfEnv" | grep "guestinfo.minecraft.pvp")


    VERSION=$(echo "${MINECRAFT_VERSION}" | awk -F 'oe:value="' '{print $2}' | awk -F '"' '{print $1}')
    SERVERPORT=$(echo "${MINECRAFT_SERVERPORT}" | awk -F 'oe:value="' '{print $2}' | awk -F '"' '{print $1}')
    RCONPORT=$(echo "${MINECRAFT_RCONPORT}" | awk -F 'oe:value="' '{print $2}' | awk -F '"' '{print $1}')
    RCONPASSWORD=$(echo "${MINECRAFT_RCONPASSWORD}" | awk -F 'oe:value="' '{print $2}' | awk -F '"' '{print $1}')
    GAMEMODE=$(echo "${MINECRAFT_GAMEMODE}" | awk -F 'oe:value="' '{print $2}' | awk -F '"' '{print $1}')
    DIFFICULTY=$(echo "${MINECRAFT_DIFFICULTY}" | awk -F 'oe:value="' '{print $2}' | awk -F '"' '{print $1}')
    LEVELNAME=$(echo "${MINECRAFT_LEVELNAME}" | awk -F 'oe:value="' '{print $2}' | awk -F '"' '{print $1}')
    LEVELSEED=$(echo "${MINECRAFT_LEVELSEED}" | awk -F 'oe:value="' '{print $2}' | awk -F '"' '{print $1}')
    LEVELTYPE=$(echo "${MINECRAFT_LEVELTYPE}" | awk -F 'oe:value="' '{print $2}' | awk -F '"' '{print $1}')
    MAXWORLDSIZE=$(echo "${MINECRAFT_MAXWORLDSIZE}" | awk -F 'oe:value="' '{print $2}' | awk -F '"' '{print $1}')
    MAXPLAYERS=$(echo "${MINECRAFT_MAXPLAYERS}" | awk -F 'oe:value="' '{print $2}' | awk -F '"' '{print $1}')

    ENABLERCON==$(echo "${MINECRAFT_ENABLERCON}" | awk -F 'oe:value="' '{print $2}' | awk -F '"' '{print $1}')
    ENABLERCON=$(echo $ENABLERCON | sed 's/=//g')
    ENABLERCON=${ENABLERCON}

    ONLINEMODE=$(echo "${MINECRAFT_ONLINEMODE}" | awk -F 'oe:value="' '{print $2}' | awk -F '"' '{print $1}')
    ONLINEMODE=$(echo $ONLINEMODE | sed 's/=//g')
    ONLINEMODE=${ONLINEMODE}
    
    ALLOWNETHER=$(echo "${MINECRAFT_ALLOWNETHER}" | awk -F 'oe:value="' '{print $2}' | awk -F '"' '{print $1}')
    ALLOWNETHER=$(echo $ALLOWNETHER | sed 's/=//g')
    ALLOWNETHER=${ALLOWNETHER}

    GENERATESTRUCTURES=$(echo "${MINECRAFT_GENERATESTRUCTURES}" | awk -F 'oe:value="' '{print $2}' | awk -F '"' '{print $1}')
    GENERATESTRUCTURES=$(echo $GENERATESTRUCTURES | sed 's/=//g')
    GENERATESTRUCTURES=${GENERATESTRUCTURES}

    SPAWNANIMALS=$(echo "${MINECRAFT_SPAWNANIMALS}" | awk -F 'oe:value="' '{print $2}' | awk -F '"' '{print $1}')
    SPAWNANIMALS=$(echo $SPAWNANIMALS | sed 's/=//g')
    SPAWNANIMALS=${SPAWNANIMALS}

    SPAWNMONSTERS=$(echo "${MINECRAFT_SPAWNMONSTERS}" | awk -F 'oe:value="' '{print $2}' | awk -F '"' '{print $1}')
    SPAWNMONSTERS=$(echo $SPAWNMONSTERS | sed 's/=//g')
    SPAWNMONSTERS=${SPAWNMONSTERS}

    SPAWNNPCS=$(echo "${MINECRAFT_SPAWNNPCS}" | awk -F 'oe:value="' '{print $2}' | awk -F '"' '{print $1}')
    SPAWNNPCS=$(echo $SPAWNNPCS | sed 's/=//g')
    SPAWNNPCS=${SPAWNNPCS}

    #PVP=$(echo "${MINECRAFT_PVP}" | awk -F 'oe:value="' '{print $2}' | awk -F '"' '{print $1}')
    #PVP=$(echo $PVP | sed 's/=//g')
    #PVP=${PVP}


##
## Download Latest Minecraft Server
##

echo '> Download Latest Minecraft Server version'
#chmod +x /opt/Minecraft/scripts/Get-MinecraftServer.ps1
#chmod +x /opt/Minecraft/scripts/Upgrade-MinecraftService.ps1
chmod -vR +x /opt/Minecraft/scripts/
pwsh -noprofile -command "/opt/Minecraft/scripts/Get-MinecraftServer.ps1 -MinecraftVersion ${VERSION}"

##
## Minecraft Server Initialization
##

echo '> Start Minecraft Server for the first time'
cd /opt/Minecraft/bin/
java -Xmx1536M -Xms512M -jar /opt/Minecraft/bin/server.jar --initSettings

##
## Minecraft Configuration File Edits
##

echo '> Edit EULA file'
sed -i 's/eula=false/eula=true/g' /opt/Minecraft/bin/eula.txt

echo '> Edit server.properties file'
sed -i "s/enable-rcon=false/enable-rcon=${ENABLERCON}/g" /opt/Minecraft/bin/server.properties
sed -i "s/rcon.password=/rcon.password=${RCONPASSWORD}/g" /opt/Minecraft/bin/server.properties
sed -i "s/rcon.port=25575/rcon.port=${RCONPORT}/g" /opt/Minecraft/bin/server.properties
sed -i "s/server-port=25565/server-port=${SERVERPORT}/g" /opt/Minecraft/bin/server.properties
sed -i "s/max-players=.*/max-players=${MAXPLAYERS}/g" /opt/Minecraft/bin/server.properties
sed -i "s/online-mode=.*/online-mode=${ONLINEMODE}/g" /opt/Minecraft/bin/server.properties
sed -i "s/gamemode=.*/gamemode=${GAMEMODE}/g" /opt/Minecraft/bin/server.properties
sed -i "s/difficulty=.*/difficulty=${DIFFICULTY}/g" /opt/Minecraft/bin/server.properties
sed -i "s/level-name=.*/level-name=${LEVELNAME}/g" /opt/Minecraft/bin/server.properties
sed -i "s/level-seed=.*/level-seed=${LEVELSEED}/g" /opt/Minecraft/bin/server.properties
sed -i "s/level-type=.*/level-type=${LEVELTYPE}/g" /opt/Minecraft/bin/server.properties
sed -i "s/max-world-size=.*/max-world-size=${MAXWORLDSIZE}/g" /opt/Minecraft/bin/server.properties
sed -i "s/allow-nether=.*/allow-nether=${ALLOWNETHER}/g" /opt/Minecraft/bin/server.properties
sed -i "s/generate-structures=.*/generate-structures=${GENERATESTRUCTURES}/g" /opt/Minecraft/bin/server.properties
sed -i "s/spawn-animals=.*/spawn-animals=${SPAWNANIMALS}/g" /opt/Minecraft/bin/server.properties
sed -i "s/spawn-monsters=.*/spawn-monsters=${SPAWNMONSTERS}/g" /opt/Minecraft/bin/server.properties
sed -i "s/spawn-npcs=.*/spawn-npcs=${SPAWNNPCS}/g" /opt/Minecraft/bin/server.properties
#sed -i "s/pvp=.*/pvp=${PVP}/g" /opt/Minecraft/bin/server.properties

##
## Minecraft Firewall Configuration
##

echo '> Configure Minecraft Firewall Rules'
#iptables -A INPUT -p tcp --dport ${SERVERPORT} -j ACCEPT
#iptables -A INPUT -p tcp --dport ${RCONPORT} -j ACCEPT
#iptables-save > /etc/iptables/rules.v4
ufw allow ${SERVERPORT}/tcp
ufw allow ${RCONPORT}/tcp

##
## Modify Minecraft Service file with correct rcon port and password
##

sed -i "s/RCONPORT/${RCONPORT}/g" /etc/systemd/system/minecraft.service
sed -i "s/RCONPASSWORD/${RCONPASSWORD}/g" /etc/systemd/system/minecraft.service

##
## Reload systemctl daemon to record changes to the minecraft service file
##

systemctl daemon-reload

##
## Minecraft folder permissions changes
##

echo '> Setting Minecraft Admins group to Owner of Opt folder'
chown -v root:minecraft-admins /opt/
chown -vR minecraft:minecraft-admins /opt/Minecraft


echo '> Setting execute permissions on server.jar'
chmod -vR 755 /opt/Minecraft

##
## Start Minecraft Server Service
##

systemctl enable minecraft.service
systemctl start minecraft.service

##
##Configure Scheduled Tasks for System and Minecraft Updates
##

echo '> Creating crontab file and adding scheduled update tasks'

CRON_FILE="/var/spool/cron/root"

	if [ ! -f $CRON_FILE ]; then
	   echo "cron file for root doesnot exist, creating.."
	   touch $CRON_FILE
	   /usr/bin/crontab $CRON_FILE
	fi

    if [ "$VERSION" = "Latest" ]; then
        echo "> Latest version selected. Configuring server to automatically update Minecraft."
        echo '* 2-4 * * * pwsh -noprofile -command "/opt/Minecraft/scripts/Upgrade-MinecraftService.ps1 -ApplyUpdate $true" ' >> $CRON_FILE

        else
        echo "> ${VERSION} specified. Minecaft Server automatic updates disabled."
	fi

    echo "> Configuring Debian Automatic Update Schedule"
    echo "* 1-2 * * * apt-get update && apt-get upgrade -y " >> $CRON_FILE
	
    echo "> Configuring Crontable file"
    /usr/bin/crontab $CRON_FILE

    echo '> Done'