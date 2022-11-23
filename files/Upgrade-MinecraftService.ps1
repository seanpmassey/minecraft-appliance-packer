Param(
    [string]$MinecraftVersion = "Latest",
    [string]$MinecraftPath = "/opt/Minecraft/bin",
    [bool]$ApplyUpgrade = $false
)

#Get Current Installed version
$properties = cat /opt/Minecraft/bin/minecraft.properties
$installedversion = $properties.split("=")[1]

write-output "The currently installed Minecraft version is $installedversion."
    
#Get Minecraft Latest Minecraft version
$mojangJSON = "https://launchermeta.mojang.com/mc/game/version_manifest.json"

$j = Invoke-WebRequest -Uri $mojangJSON | ConvertFrom-Json

If($MinecraftVersion -ne "Latest"){
    $releaseversion = $MinecraftVersion
}Else{
    $releaseversion = $j.latest.release
}

$releasedata = $j.versions | where-object {($_.id -eq $releaseversion) -and ($_.type -eq "release")}
$targetreleaseversion = $releasedata.id

If($installedversion -lt $targetreleaseversion){
    #Retrieve Minecraft download URL for selected version
    write-output "A Minecraft update is available.  The target upgrade version is $targetreleaseversion."
}
Else{
    Write-Output "You on on the latest release, or on a version that is newer than the target version."
    Break
}

If($ApplyUpgrade -ne $false){
    $servicestatus = systemctl is-active minecraft

    if($servicestatus -eq "active"){
        Write-Output "The Minecraft Service is running.  Stopping."
        systemctl stop minecraft
        start-sleep -Seconds 5
        while ($servicestatus -eq "active") {
            $servicestatus = systemctl is-active minecraft
            Write-Output "The Minecraft service is still Active. Waiting five more seconds."
        }
    }else{
        Write-Output "The Minecraft service is not running."
    }

    Write-Output "Starting Upgrade."
    $versionURL = $releasedata.url
    $versionJSON = Invoke-WebRequest -Uri $versionURL | ConvertFrom-Json
    $serverdownloadURL = ($versionJSON.downloads.server).url

    #Download server.jar file
    Invoke-WebRequest -Uri $serverdownloadURL -Outfile /opt/Minecraft/bin/server.jar

    Write-Output "minecraftversion=$targetreleaseversion" > /opt/Minecraft/bin/minecraft.properties

    #Resetting File Permissions and File Onwership on Minecraft bin folder
    chown -vR minecraft:minecraft-admins /opt/Minecraft/
    chmod -vR 755 /opt/Minecraft

    Write-Output "Upgrade Complete.  Starting Minecraft service."
    systemctl start minecraft
}