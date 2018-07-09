# 
# NAME
#     Get-CCMLog
#     
# SYNOPSIS
#     Short description
#     
#     
# SYNTAX
#     Get-CCMLog [-ComputerName] <Object> [-path] <Object> [<CommonParameters>]
#     
#     
# DESCRIPTION
#     Long description
#     
# 
# RELATED LINKS
# 
# REMARKS
#     To see the examples, type: "get-help Get-CCMLog -examples".
#     For more information, type: "get-help Get-CCMLog -detailed".
#     For technical information, type: "get-help Get-CCMLog -full".
# 
# 
# 
function Get-CCMLog 
{

    param([Parameter(Mandatory=$true,Position=0)]$ComputerName = '$env:computername', [Parameter(Mandatory=$true,Position=1)]$path = 'c:\windows\ccm\logs')
    DynamicParam
    {
        $ParameterName = 'Log'
        if($path.ToCharArray() -contains ':')
        {

            $FilePath = "\\$($ComputerName)\$($path -replace ':','$')"
        }
        else
        {
            $FilePath = "\\$($ComputerName)\$((get-item $path).FullName -replace ':','$')"
        }
        
        $logs = Get-ChildItem "$FilePath\*.log"
        $LogNames = $logs.basename

        $logAttribute = New-Object System.Management.Automation.ParameterAttribute
        $logAttribute.Position = 2
        $logAttribute.Mandatory = $true
        $logAttribute.HelpMessage = 'Pick A log to parse'                

        $logCollection = New-Object System.Collections.ObjectModel.Collection[System.Attribute]
        $logCollection.add($logAttribute)

        $logValidateSet = New-Object System.Management.Automation.ValidateSetAttribute($LogNames)
        $logCollection.add($logValidateSet)

        $logParam = New-Object System.Management.Automation.RuntimeDefinedParameter($ParameterName,[string],$logCollection)

        $logDictionary = New-Object System.Management.Automation.RuntimeDefinedParameterDictionary
        $logDictionary.Add($ParameterName,$logParam)
        return $logDictionary
           
        
    }
    begin {
        # Bind the parameter to a friendly variable
        $Log = $PsBoundParameters[$ParameterName]
    }

    process {
        $i = [system.net.dns]::GetHostAddresses('localhost').ipaddresstostring
        $I+=[system.net.dns]::GetHostAddresses($env:COMPUTERNAME).ipaddresstostring
        if( ([system.net.dns]::GetHostAddresses($ComputerName).ipaddresstostring | Where-object{$i -contains $_}) -gt 0)
        {
            $results = get-cmlog -Path  "$path\$log.log"
        }
        else
        {
            $sb2 = "$((Get-ChildItem function:get-cmlog).scriptblock)`r`n"
            $sb1 = [scriptblock]::Create($sb2)
            $results = Invoke-Command -ComputerName $ComputerName -ScriptBlock $sb1 -ArgumentList "$path\$log.log"   
        }
        [PSCustomObject]@{"$($log)Log"=$results}
    }



}
