Import-Module 'C:\Program Files\Microsoft Dynamics 365 Business Central\140\Service\NavAdminTool.ps1'

$NavInstance =  'BC140M'
$ExtName = 'ContractMgt'
$ExtPath = 'G:\BeeCoding\github\BC365M\BeeCoding_ContractMgt_1.0.0.0.app'

UnInstall-NAVApp -ServerInstance $NavInstance  -Name $ExtName 
UnPublish-NAVApp -ServerInstance $NavInstance -Name $ExtName


Publish-NAVApp -ServerInstance $NavInstance -Path $ExtPath -SkipVerification
Sync-NAVApp -ServerInstance $NavInstance -Name $ExtName -Mode ForceSync
Install-NAVApp -ServerInstance $NavInstance -Path $ExtPath
