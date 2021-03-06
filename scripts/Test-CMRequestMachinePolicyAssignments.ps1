# 
# NAME
#     Test-CMRequestMachinePolicyAssignments
#     
# SYNOPSIS
#     Short description
#     
#     
# SYNTAX
#     Test-CMRequestMachinePolicyAssignments [-computername] <Object> [-Path] <Object> [-SUGpolicy] <Object> [-TimeReference] <DateTime> [<CommonParameters>]
#     
#     
# DESCRIPTION
#     Long description
#     
# 
# RELATED LINKS
# 
# REMARKS
#     To see the examples, type: "get-help Test-CMRequestMachinePolicyAssignments -examples".
#     For more information, type: "get-help Test-CMRequestMachinePolicyAssignments -detailed".
#     For technical information, type: "get-help Test-CMRequestMachinePolicyAssignments -full".
# 
# 
# 
function Test-CMRequestMachinePolicyAssignments 
{

    param([Parameter(Mandatory=$true)]$computername, [Parameter(Mandatory=$true)]$Path = 'c:\windows\ccm\logs',[Parameter(Mandatory=$true)]$SUGpolicy,[Parameter(Mandatory=$true)][datetime]$TimeReference)
    
    $RequestMachinePolicyAssignments = $false
    #$devPolicy = 'ScopeId_3B249A78-5440-4774-A147-756BECBCB669/AuthList_2FCE0C56-57F8-44A1-924B-1492829A9C6D/VI'
    #$prodPolicy = ''
    # can see when this is requested from the Policy agentlog:
    Push-Location
    Set-Location c:
    $p = Get-CCMLog -ComputerName $computerName -path $Path -log PolicyAgent
    Pop-Location
    $runResults = $P.PolicyAgentLog |Where-Object{$_.Localtime -gt $TimeReference} | where-object {$_.message -like "*Applying policy $SUGPolicy*"}
        if($runResults)
        {
            $RequestMachinePolicyAssignments = $true
        }
    $RequestMachinePolicyAssignments


}
