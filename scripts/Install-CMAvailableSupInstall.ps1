# 
# NAME
#     Install-CMAvailableSupInstall
#     
# SYNOPSIS
#     Short description
#     
#     
# SYNTAX
#     Install-CMAvailableSupInstall [-ComputerName] <String> [-SupName] <String> [<CommonParameters>]
#     
#     
# DESCRIPTION
#     Long description
#     
# 
# RELATED LINKS
# 
# REMARKS
#     To see the examples, type: "get-help Install-CMAvailableSupInstall -examples".
#     For more information, type: "get-help Install-CMAvailableSupInstall -detailed".
#     For technical information, type: "get-help Install-CMAvailableSupInstall -full".
# 
# 
# 
function Install-CMAvailableSupInstall 
{

 Param
(
 [String][Parameter(Mandatory=$True, Position=1)] $ComputerName,
 [String][Parameter(Mandatory=$True, Position=2)] $SupName
 
)
Begin
{
 $AppEvalState0 = "0"
 $AppEvalState1 = "1"
 #$ApplicationClass = [WmiClass]"root\ccm\clientSDK:CCM_SoftwareUpdatesManager"
}
 
Process
{
If ($SupName -Like "All" -or $SupName -like "all")
{
 Foreach ($Computer in $ComputerName)
{
 $Application = (Get-WmiObject -Namespace "root\ccm\clientSDK" -Class CCM_SoftwareUpdate -ComputerName $Computer | Where-Object { $_.EvaluationState -like "*$($AppEvalState0)*" -or $_.EvaluationState -like "*$($AppEvalState1)*"})
 Invoke-WmiMethod -Class CCM_SoftwareUpdatesManager -Name InstallUpdates -ArgumentList (,$Application) -Namespace root\ccm\clientsdk -ComputerName $Computer

}
 
}
 Else
 
{
 Foreach ($Computer in $ComputerName)
{
 $Application = (Get-WmiObject -Namespace "root\ccm\clientSDK" -Class CCM_SoftwareUpdate -ComputerName $Computer | Where-Object { $_.EvaluationState -like "*$($AppEvalState)*" -and $_.Name -like "*$($SupName)*"})
 Invoke-WmiMethod -Class CCM_SoftwareUpdatesManager -Name InstallUpdates -ArgumentList (,$Application) -Namespace root\ccm\clientsdk -ComputerName $Computer
 
}
 
}
}
End {}


}
