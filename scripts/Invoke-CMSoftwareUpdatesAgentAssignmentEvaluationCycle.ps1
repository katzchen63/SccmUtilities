# 
# NAME
#     Invoke-CMSoftwareUpdatesAgentAssignmentEvaluationCycle
#     
# SYNOPSIS
#     Runs a trigger for SoftwareUPdages Agent Assignment Evaluation Cycle
#     
#     
# SYNTAX
#     Invoke-CMSoftwareUpdatesAgentAssignmentEvaluationCycle [-computername] <Object> [-path] <Object> [<CommonParameters>]
#     
#     
# DESCRIPTION
#     Long description
#     
# 
# RELATED LINKS
# 
# REMARKS
#     To see the examples, type: "get-help Invoke-CMSoftwareUpdatesAgentAssignmentEvaluationCycle -examples".
#     For more information, type: "get-help Invoke-CMSoftwareUpdatesAgentAssignmentEvaluationCycle -detailed".
#     For technical information, type: "get-help Invoke-CMSoftwareUpdatesAgentAssignmentEvaluationCycle -full".
# 
# 
# 
function Invoke-CMSoftwareUpdatesAgentAssignmentEvaluationCycle 
{

    param([Parameter(Mandatory=$true)]$computername,[Parameter(Mandatory=$true)]$path ='c:\windows\ccm\logs')
    [datetime]$TimeReference = invoke-command -ComputerName $computername -scriptblock {get-date}
    $SmsClient =[wmiclass]("\\$ComputerName\ROOT\ccm:SMS_Client")
    $SmsClient.TriggerSchedule($Sccmhash["SoftwareUpdatesAgentAssignmentEvaluationCycle"])
    $SoftwareUpdatesAgentAssignmentEvaluationCycle = Test-CMSoftwareUpdatesAgentAssignmentEvaluationCycle -computername $computername -path $path -TimeReference $TimeReference
    [PSCustomObject]@{'SoftwareUpdatesAgentAssignmentEvaluationCycle' = $SoftwareUpdatesAgentAssignmentEvaluationCycle
                      'TimeReference' =[datetime] $TimeReference}


}
