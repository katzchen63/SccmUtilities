# 
# NAME
#     Test-CMForceUpdatescan
#     
# SYNOPSIS
#     Short description
#     
#     
# SYNTAX
#     Test-CMForceUpdatescan [-computername] <Object> [-TimeReference] <DateTime> [<CommonParameters>]
#     
#     
# DESCRIPTION
#     Long description
#     
# 
# RELATED LINKS
# 
# REMARKS
#     To see the examples, type: "get-help Test-CMForceUpdatescan -examples".
#     For more information, type: "get-help Test-CMForceUpdatescan -detailed".
#     For technical information, type: "get-help Test-CMForceUpdatescan -full".
# 
# 
# 
function Test-CMForceUpdatescan 
{

    param([Parameter(Mandatory=$true)]$computername,[Parameter(Mandatory=$true)][datetime]$TimeReference)
    $Sccmhash = New-CMSccmTriggerHashTable
    [datetime]$TimeReference = invoke-command -ComputerName $computername -scriptblock {get-date}
    $SmsClient.TriggerSchedule($Sccmhash['ForceupdateScan'])
    #When the scan is done you'll get a completion time close to when you isseud the command
    $TimeReferenceEnd = $false
    $TimeReferenceEnd = Get-WmiObject -ComputerName $computerName  -Namespace root\ccm\scanagent -Query "select LastCompletionTime from CCM_ScanUpdateSourceHistory"| ForEach-Object{ [management.managementDateTimeConverter]::ToDateTime($_.LastCompletionTime) }
    if($TimeReferenceEnd -gt $TimeReference)
    { $forceupdateScan = $true} 
    $forceupdateScan


}
