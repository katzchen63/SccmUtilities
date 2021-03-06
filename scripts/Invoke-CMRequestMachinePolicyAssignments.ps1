# 
# NAME
#     Invoke-CMRequestMachinePolicyAssignments
#     
# SYNOPSIS
#     Short description
#     
#     
# SYNTAX
#     Invoke-CMRequestMachinePolicyAssignments [-computername] <Object> [-Path] <Object> [-SUGpolicy] <Object> [<CommonParameters>]
#     
#     
# DESCRIPTION
#     Long description
#     
# 
# RELATED LINKS
# 
# REMARKS
#     To see the examples, type: "get-help Invoke-CMRequestMachinePolicyAssignments -examples".
#     For more information, type: "get-help Invoke-CMRequestMachinePolicyAssignments -detailed".
#     For technical information, type: "get-help Invoke-CMRequestMachinePolicyAssignments -full".
# 
# 
# 
function Invoke-CMRequestMachinePolicyAssignments 
{

    param([Parameter(Mandatory=$true)]$computername, [Parameter(Mandatory=$true)]$Path = 'c:\windows\ccm\logs',[Parameter(Mandatory=$true)]$SUGpolicy ='ScopeId_3B249A78-5440-4774-A147-756BECBCB669/AuthList_2FCE0C56-57F8-44A1-924B-1492829A9C6D/VI')
    $Sccmhash = New-CMSccmTriggerHashTable
    [datetime]$TimeReference = invoke-command -ComputerName $computername -scriptblock {get-date}
    $SmsClient =[wmiclass]("\\$ComputerName\ROOT\ccm:SMS_Client")
    $SmsClient.TriggerSchedule($Sccmhash["RequestMachinePolicyAssignments"])
    $RequestMachinePolicyAssignments = $false

    # can see when this is requested from the Policy agentlog:
    $RequestMachinePolicyAssignments = Test-CMRequestMachinePolicyAssignments -computername $computername -Path $Path -SUGpolicy $SUGpolicy -TimeReference $TimeReference
    
    [PSCustomObject]@{'RequestMachinePolicyAssignments' = $RequestMachinePolicyAssignments
                      'TimeReference' = [datetime]$TimeReference}


}
