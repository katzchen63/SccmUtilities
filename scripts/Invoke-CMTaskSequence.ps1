# 
# NAME
#     Invoke-CMTaskSequence
#     
# SYNTAX
#     Invoke-CMTaskSequence [-Computername] <string> [-PackageID] <string>  [<CommonParameters>]
#     
# 
# ALIASES
#     None
#     
# 
# REMARKS
#     None
# 
# 
# 
function Invoke-CMTaskSequence 
{
 
 Param 
( 
 [String][Parameter(Mandatory=$True, Position=1)] $Computername, 
 [String][Parameter(Mandatory=$True, Position=2)] $PackageID 
 
) 
Begin 
{ 
 
     
} 
 
Process 
{ 
   
 $CIMopt = New-CimSessionOption -Protocol Wsman
 $CIMSess = New-CimSession -ComputerName $Computername -SessionOption $CIMopt
 $CIMClass = (Get-CimClass -Namespace root\ccm\clientsdk -CimSession $CIMSess -ClassName CCM_ProgramsManager) 
 $OSD = (Get-CimInstance  -ClassName CCM_Program -Namespace "root\ccm\clientSDK" -CimSession $CIMSess| Where-Object {$_.PackageID -like "$PackageID"}) 
  
 $Args = @{PackageID = $OSD.PackageID 
          ProgramID = $OSD.ProgramID 
          }
Invoke-CimMethod -CimClass $CIMClass -CimSession $CIMSess -MethodName "ExecuteProgram" –Arguments $Args
           
 
} 
End {
    
} 


}
