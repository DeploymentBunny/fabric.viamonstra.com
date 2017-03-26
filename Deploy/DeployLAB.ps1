#Deploy the entire Solution

#Read data from Bootstrap XML
$Global:BootstrapFile = "C:\Setup\fabric.viamonstra.com\Deploy\Bootstrap_$env:COMPUTERNAME.xml"
[xml]$Global:Bootstrap = Get-Content $BootstrapFile -ErrorAction Stop

#Read data from XML
$Global:SettingsFile = "C:\Setup\fabric.viamonstra.com\Deploy\fabric.viamonstra.com.xml"
[xml]$Global:Settings = Get-Content $SettingsFile -ErrorAction Stop

#Set Vars
$Global:Solution = $Bootstrap.BootStrap.CommonSettings.CommonSetting.Solution
$Global:Logpath = $Bootstrap.BootStrap.CommonSettings.CommonSetting.Logpath
$Global:DomainName = $Settings.Settings.Customers.Customer.PrimaryDomainName
$Global:VMlocation = ($Bootstrap.BootStrap.Folders.Folder | Where-Object -Property Name -EQ -Value VMFolder).path
$MediaISOData = $Bootstrap.BootStrap.ISOs.ISO | Where-Object -Property Name -EQ -Value HYDv10.iso
$Global:MediaISO = $MediaISOData.Path + '\' + $MediaISOData.Name
$Global:VMSwitchName = $Bootstrap.BootStrap.CommonSettings.CommonSetting.VMSwitch

#Disable verbose for testing
#$Global:VerbosePreference = "Continue"
$Global:VerbosePreference = "SilentlyContinue"

#Import-Modules
Import-Module -Global C:\Setup\Functions\VIAHypervModule.psm1 -Force
Import-Module -Global C:\Setup\Functions\VIAUtilityModule.psm1 -Force
Import-Module -Global C:\Setup\Functions\VIAXMLUtility.psm1 -Force
Import-Module -Global C:\Setup\Functions\VIADeployModule.psm1 -Force

#Enable verbose for testing
$Global:VerbosePreference = "Continue"
#$Global:VerbosePreference = "SilentlyContinue"

#Deploy ADDS01
$Global:Server = 'ADDS01'
$FinishAction = 'NONE'
$VHDImageData = $Bootstrap.BootStrap.VHDs.VHD | Where-Object -Property name -EQ -Value WS2016_Datacenter_UEFI_GUI_EVAL_Fabric.vhdx
$Global:VHDImage = $VHDImageData.Path + '\' + $VHDImageData.Name
C:\Setup\HYDv10\TaskSequences\DeployFABRICServer.ps1 -BootstrapFile $BootstrapFile -SettingsFile $SettingsFile -VHDImage $VHDImage -VMlocation $VMlocation -LogPath $Logpath -DomainName $DomainName -Server $Server -VMSwitchName $VMSwitchName -FinishAction $FinishAction -KeepMountedMedia

#Deploy SNAT01
$Global:Server = 'SNAT01'
$Global:Roles = 'SNAT'
$FinishAction = 'Shutdown'
$VHDImageData = $Bootstrap.BootStrap.VHDs.VHD | Where-Object -Property name -EQ -Value WS2016_Datacenter_UEFI_GUI_EVAL_Fabric.vhdx
$Global:VHDImage = $VHDImageData.Path + '\' + $VHDImageData.Name
C:\Setup\HYDv10\TaskSequences\DeployFABRICServer.ps1 -BootstrapFile $BootstrapFile -SettingsFile $SettingsFile -VHDImage $VHDImage -VMlocation $VMlocation -LogPath $Logpath -DomainName $DomainName -Server $Server -VMSwitchName $VMSwitchName -FinishAction $FinishAction -Roles $Roles -KeepMountedMedia

#Deploy vHOST11
#$Global:Server = 'vHOST11'
#$Global:Roles = 'vConverged'
#$FinishAction = 'Shutdown'
#$VHDImageData = $Bootstrap.BootStrap.VHDs.VHD | Where-Object -Property name -EQ -Value WS2016_Datacenter_UEFI_GUI_EVAL_Fabric.vhdx
#$Global:VHDImage = $VHDImageData.Path + '\' + $VHDImageData.Name
#C:\Setup\HYDv10\TaskSequences\DeployFABRICServer.ps1 -BootstrapFile $BootstrapFile -SettingsFile $SettingsFile -VHDImage $VHDImage -VMlocation $VMlocation -LogPath $Logpath -DomainName $DomainName -Server $Server -VMSwitchName $VMSwitchName -FinishAction $FinishAction -Roles $Roles -KeepMountedMedia

#Deploy vHOST12
#$Global:Server = 'vHOST12'
#$Global:Roles = 'vConverged'
#$FinishAction = 'Shutdown'
#$VHDImageData = $Bootstrap.BootStrap.VHDs.VHD | Where-Object -Property name -EQ -Value WS2016_Datacenter_UEFI_GUI_EVAL_Fabric.vhdx
#$Global:VHDImage = $VHDImageData.Path + '\' + $VHDImageData.Name
#C:\Setup\HYDv10\TaskSequences\DeployFABRICServer.ps1 -BootstrapFile $BootstrapFile -SettingsFile $SettingsFile -VHDImage $VHDImage -VMlocation $VMlocation -LogPath $Logpath -DomainName $DomainName -Server $Server -VMSwitchName $VMSwitchName -FinishAction $FinishAction -Roles $Roles -KeepMountedMedia

#Deploy DEPL01
#$Global:Server = 'DEPL01'
#$Global:Roles = 'DEPL'
#$FinishAction = 'Shutdown'
#$VHDImageData = $Bootstrap.BootStrap.VHDs.VHD | Where-Object -Property name -EQ -Value WS2016_Datacenter_UEFI_GUI_EVAL_Fabric.vhdx
#$Global:VHDImage = $VHDImageData.Path + '\' + $VHDImageData.Name
#C:\Setup\HYDv10\TaskSequences\DeployFABRICServer.ps1 -BootstrapFile $BootstrapFile -SettingsFile $SettingsFile -VHDImage $VHDImage -VMlocation $VMlocation -LogPath $Logpath -DomainName $DomainName -Server $Server -VMSwitchName $VMSwitchName -FinishAction $FinishAction -Roles $Roles -KeepMountedMedia

#Deploy WSUS01
#$Global:Server = 'WSUS01'
#$Global:Roles = 'WSUS'
#$FinishAction = 'Shutdown'
#$VHDImageData = $Bootstrap.BootStrap.VHDs.VHD | Where-Object -Property name -EQ -Value WS2016_Datacenter_UEFI_GUI_EVAL_Fabric.vhdx
#$Global:VHDImage = $VHDImageData.Path + '\' + $VHDImageData.Name
#C:\Setup\HYDv10\TaskSequences\DeployFABRICServer.ps1 -BootstrapFile $BootstrapFile -SettingsFile $SettingsFile -VHDImage $VHDImage -VMlocation $VMlocation -LogPath $Logpath -DomainName $DomainName -Server $Server -VMSwitchName $VMSwitchName -FinishAction $FinishAction -Roles $Roles -KeepMountedMedia

#Deploy SCVM01
$Global:Server = 'SCVM01'
$Global:Roles = 'SCVM2016'
$FinishAction = 'Shutdown'
$VHDImageData = $Bootstrap.BootStrap.VHDs.VHD | Where-Object -Property name -EQ -Value WS2016_Datacenter_UEFI_GUI_EVAL_Fabric.vhdx
$Global:VHDImage = $VHDImageData.Path + '\' + $VHDImageData.Name
C:\Setup\HYDv10\TaskSequences\DeployFABRICServer.ps1 -BootstrapFile $BootstrapFile -SettingsFile $SettingsFile -VHDImage $VHDImage -VMlocation $VMlocation -LogPath $Logpath -DomainName $DomainName -Server $Server -VMSwitchName $VMSwitchName -FinishAction $FinishAction -Roles $Roles -KeepMountedMedia

#Deploy SCOM01
$Global:Server = 'SCOM01'
$Global:Roles = 'SCOM2016'
$FinishAction = 'Shutdown'
$VHDImageData = $Bootstrap.BootStrap.VHDs.VHD | Where-Object -Property name -EQ -Value WS2016_Datacenter_UEFI_GUI_EVAL_Fabric.vhdx
$Global:VHDImage = $VHDImageData.Path + '\' + $VHDImageData.Name
C:\Setup\HYDv10\TaskSequences\DeployFABRICServer.ps1 -BootstrapFile $BootstrapFile -SettingsFile $SettingsFile -VHDImage $VHDImage -VMlocation $VMlocation -LogPath $Logpath -DomainName $DomainName -Server $Server -VMSwitchName $VMSwitchName -FinishAction $FinishAction -Roles $Roles -KeepMountedMedia

#Deploy SCOR01
#$Global:Server = 'SCOR01'
#$Global:Roles = 'SCOR2016'
#$FinishAction = 'Shutdown'
#$VHDImageData = $Bootstrap.BootStrap.VHDs.VHD | Where-Object -Property name -EQ -Value WS2016_Datacenter_UEFI_GUI_EVAL_Fabric.vhdx
#$Global:VHDImage = $VHDImageData.Path + '\' + $VHDImageData.Name
#C:\Setup\HYDv10\TaskSequences\DeployFABRICServer.ps1 -BootstrapFile $BootstrapFile -SettingsFile $SettingsFile -VHDImage $VHDImage -VMlocation $VMlocation -LogPath $Logpath -DomainName $DomainName -Server $Server -VMSwitchName $VMSwitchName -FinishAction $FinishAction -Roles $Roles -KeepMountedMedia

#Deploy WAP01
#$Global:Server = 'WAP01'
#$Global:Roles = 'WAP'
#$FinishAction = 'Shutdown'
#$VHDImageData = $Bootstrap.BootStrap.VHDs.VHD | Where-Object -Property name -EQ -Value WS2016_Datacenter_UEFI_GUI_EVAL_Fabric.vhdx
#$Global:VHDImage = $VHDImageData.Path + '\' + $VHDImageData.Name
#C:\Setup\HYDv10\TaskSequences\DeployFABRICServer.ps1 -BootstrapFile $BootstrapFile -SettingsFile $SettingsFile -VHDImage $VHDImage -VMlocation $VMlocation -LogPath $Logpath -DomainName $DomainName -Server $Server -VMSwitchName $VMSwitchName -FinishAction $FinishAction -Roles $Roles -KeepMountedMedia

#Deploy SCDP01
#$Global:Server = 'SCDP01'
#$Global:Roles = 'SCDP'
#$FinishAction = 'Shutdown'
#$VHDImageData = $Bootstrap.BootStrap.VHDs.VHD | Where-Object -Property name -EQ -Value WS2016_Datacenter_UEFI_GUI_EVAL_Fabric.vhdx
#$Global:VHDImage = $VHDImageData.Path + '\' + $VHDImageData.Name
#C:\Setup\HYDv10\TaskSequences\DeployFABRICServer.ps1 -BootstrapFile $BootstrapFile -SettingsFile $SettingsFile -VHDImage $VHDImage -VMlocation $VMlocation -LogPath $Logpath -DomainName $DomainName -Server $Server -VMSwitchName $VMSwitchName -FinishAction $FinishAction -Roles $Roles -KeepMountedMedia

#Deploy RDGW01
#$Global:Server = 'RDGW01'
#$Global:Roles = 'RDGW'
#$FinishAction = 'Shutdown'
#$VHDImageData = $Bootstrap.BootStrap.VHDs.VHD | Where-Object -Property name -EQ -Value WS2016_Datacenter_UEFI_GUI_EVAL_Fabric.vhdx
#$Global:VHDImage = $VHDImageData.Path + '\' + $VHDImageData.Name
#C:\Setup\HYDv10\TaskSequences\DeployFABRICServer.ps1 -BootstrapFile $BootstrapFile -SettingsFile $SettingsFile -VHDImage $VHDImage -VMlocation $VMlocation -LogPath $Logpath -DomainName $DomainName -Server $Server -VMSwitchName $VMSwitchName -FinishAction $FinishAction -Roles $Roles -KeepMountedMedia

#Deploy ADCA01
#$Global:Server = 'ADCA01'
#$Global:Roles = 'ADCA'
#$FinishAction = 'NONE'
#$VHDImageData = $Bootstrap.BootStrap.VHDs.VHD | Where-Object -Property name -EQ -Value WS2016_Datacenter_UEFI_GUI_EVAL_Fabric.vhdx
#$Global:VHDImage = $VHDImageData.Path + '\' + $VHDImageData.Name
#C:\Setup\HYDv10\TaskSequences\DeployFABRICServer.ps1 -BootstrapFile $BootstrapFile -SettingsFile $SettingsFile -VHDImage $VHDImage -VMlocation $VMlocation -LogPath $Logpath -DomainName $DomainName -Server $Server -VMSwitchName $VMSwitchName -FinishAction $FinishAction -Roles $Roles -KeepMountedMedia

#Deploy RDGW02
#$Global:Server = 'RDGW02'
#$Global:Roles = 'WAPRDGW'
#$FinishAction = 'Shutdown'
#$VHDImageData = $Bootstrap.BootStrap.VHDs.VHD | Where-Object -Property name -EQ -Value WS2016_Datacenter_UEFI_GUI_EVAL_Fabric.vhdx
#$Global:VHDImage = $VHDImageData.Path + '\' + $VHDImageData.Name
#C:\Setup\HYDv10\TaskSequences\DeployFABRICServer.ps1 -BootstrapFile $BootstrapFile -SettingsFile $SettingsFile -VHDImage $VHDImage -VMlocation $VMlocation -LogPath $Logpath -DomainName $DomainName -Server $Server -VMSwitchName $VMSwitchName -FinishAction $FinishAction -Roles $Roles -KeepMountedMedia

#Deploy NETCON01
#$Global:Server = 'NETCON01'
#$Global:Roles = 'NETCON'
#$FinishAction = 'Shutdown'
#$VHDImageData = $Bootstrap.BootStrap.VHDs.VHD | Where-Object -Property name -EQ -Value WS2016_Datacenter_UEFI_GUI_EVAL_Fabric.vhdx
#$Global:VHDImage = $VHDImageData.Path + '\' + $VHDImageData.Name
#C:\Setup\HYDv10\TaskSequences\DeployFABRICServer.ps1 -BootstrapFile $BootstrapFile -SettingsFile $SettingsFile -VHDImage $VHDImage -VMlocation $VMlocation -LogPath $Logpath -DomainName $DomainName -Server $Server -VMSwitchName $VMSwitchName -FinishAction $FinishAction -Roles $Roles -KeepMountedMedia

#Check log
Get-Content -Path $Logpath
