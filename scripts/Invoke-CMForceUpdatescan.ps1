# 
# NAME
#     Invoke-CMForceUpdatescan
#     
# SYNOPSIS
#     Short description
#     
#     
# SYNTAX
#     Invoke-CMForceUpdatescan [-computername] <Object> [<CommonParameters>]
#     
#     
# DESCRIPTION
#     Long description
#     
# 
# RELATED LINKS
# 
# REMARKS
#     To see the examples, type: "get-help Invoke-CMForceUpdatescan -examples".
#     For more information, type: "get-help Invoke-CMForceUpdatescan -detailed".
#     For technical information, type: "get-help Invoke-CMForceUpdatescan -full".
# 
# 
# 
function Invoke-CMForceUpdatescan 
{

    param([Parameter(Mandatory=$true)]$computername)
    $Sccmhash = New-CMSccmTriggerHashTable
    [datetime]$TimeReference = invoke-command -ComputerName $computername -scriptblock {get-date}
    $SmsClient =[wmiclass]("\\$ComputerName\ROOT\ccm:SMS_Client")
    $SmsClient.TriggerSchedule($Sccmhash['ForceupdateScan'])
    $forceupdateScan = Test-CMForceUpdatescan -computername $computername -TimeReference $TimeReference 
    #When the scan is done you'll get a completion time close to when you isseud the command
    [PSCustomObject]@{'forceupdateScan' = $forceupdateScan
    'TimeReference' = [datetime]$TimeReference}


}
