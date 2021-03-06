# 
# NAME
#     Test-CMSoftwareUpdatesAgentAssignmentEvaluationCycle
#     
# SYNOPSIS
#     Short description
#     
#     
# SYNTAX
#     Test-CMSoftwareUpdatesAgentAssignmentEvaluationCycle [-computername] <Object> [-path] <Object> [-TimeReference] <DateTime> [<CommonParameters>]
#     
#     
# DESCRIPTION
#     Long description
#     
# 
# RELATED LINKS
# 
# REMARKS
#     To see the examples, type: "get-help Test-CMSoftwareUpdatesAgentAssignmentEvaluationCycle -examples".
#     For more information, type: "get-help Test-CMSoftwareUpdatesAgentAssignmentEvaluationCycle -detailed".
#     For technical information, type: "get-help Test-CMSoftwareUpdatesAgentAssignmentEvaluationCycle -full".
# 
# 
# 
function Test-CMSoftwareUpdatesAgentAssignmentEvaluationCycle 
{

    param([Parameter(Mandatory=$true)]$computername,[Parameter(Mandatory=$true)]$path ='c:\windows\ccm\logs',[Parameter(Mandatory=$true)][datetime]$TimeReference )
    $SoftwareUpdatesAgentAssignmentEvaluationCycle = $false
    Push-Location
    Set-Location c:
    $SmsClientMethodProvider = Get-CCMLog -ComputerName $computerName -path  -log SmsClientMethodProvider
    Pop-Location
    $RunObject = $SmsClientMethodProvider.SmsClientMethodProviderLog | Where-Object{$_.Localtime -gt $TimeReference} | where-object {$_.message -like "*$($Sccmhash["SoftwareUpdatesAgentAssignmentEvaluationCycle"])*" }
    $results = $SmsClientMethodProvider.SmsClientMethodProviderLog | where-object{$_.runspaceid -eq $RunObject.runspaceid} | Where-Object{$_.Localtime -gt $TimeReference}
    If($results | Where-Object{$_.message -eq 'Schedule successfully sent.'})
    {
        $SoftwareUpdatesAgentAssignmentEvaluationCycle =$true
    }
    $SoftwareUpdatesAgentAssignmentEvaluationCycle


}
