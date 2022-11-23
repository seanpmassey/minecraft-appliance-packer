Param(
    [string]$MinecraftVersion = "Latest",
    [string]$MinecraftPath = "/opt/Minecraft/bin" 
)

$mojangJSON = "https://launchermeta.mojang.com/mc/game/version_manifest.json"

$j = Invoke-WebRequest -Uri $mojangJSON | ConvertFrom-Json

If($MinecraftVersion -ne "Latest"){
    $releaseversion = $MinecraftVersion
}Else{
    $releaseversion = $j.latest.release
}

$releasedata = $j.versions | where-object {($_.id -eq $releaseversion) -and ($_.type -eq "release")}

If($releasedata -ne $null){
    #Retrieve Minecraft download URL for selected version
    $versionid = $releasedata.id
    write-output "Selected Minecraft version is $versionid. This version will be downloaded."
    $versionURL = $releasedata.url
    $versionJSON = Invoke-WebRequest -Uri $versionURL | ConvertFrom-Json
    $serverdownloadURL = ($versionJSON.downloads.server).url

    #Download server.jar file
    Invoke-WebRequest -Uri $serverdownloadURL -Outfile /opt/Minecraft/bin/server.jar

    Write-Output "minecraftversion=$versionid" > /opt/Minecraft/bin/minecraft.properties
}
Else{
    Write-Output "The specified version was not found. Exiting"
    Break
}
