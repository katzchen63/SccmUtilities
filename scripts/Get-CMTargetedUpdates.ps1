# 
# NAME
#     Get-CMTargetedUpdates
#     
# SYNTAX
#     Get-CMTargetedUpdates [[-ComputerName] <Object>]  
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
function Get-CMTargetedUpdates 
{

    Param($ComputerName)
    $statusHash = [hashtable]@{
        "0" = 'No Content Sources'
        "1" = 'Available'
        "2" = 'Submitted'
        "3" = 'Detecting'
        "4" = 'Downloading CIDef'
        "5" = 'Downloading SdmPkg'
        "6" = 'PreDownload'
        "7" = 'Downloading'
        "8" = 'Wait Install'
        "9" = 'Installing'
        "10" = 'Pending Soft Reboot'
        "11" = 'Pending Hard Reboot'
        "12" = 'Wait Reboot'
        "13" = 'Verifying'
        "14" = 'Install Complete'
        "15" = 'State Error'
        "16" = 'Wait Service Window'
} 

$DPLocalityHash = [hashtable]@{
        "10" = 'UNPROTECTED DP'
        "74" = 'PROTECTED DP'
  
} 
    $TargetedUpdates = Get-WmiObject -Query "Select * from CCM_TargetedUpdateEX1 where UpdateState = 0" -Namespace root\ccm\SoftwareUpdates\DeploymentAgent -Computer $ComputerName -ErrorAction Stop

    if($TargetedUpdates)
    {
        $iMissing=0
        
        #loop through updates and get the details.
        ForEach($t in $TargetedUpdates)
        {
            #get the GUID
            $uID=$t.UpdateID | Select-String -Pattern "SUM_[0-9a-fA-F]{8}\-[0-9a-fA-F]{4}\-[0-9a-fA-F]{4}\-[0-9a-fA-F]{4}\-[0-9a-fA-F]{12}" | Select-Object -Expand Matches | Select-Object -Expand Value
            #strip out the SUM_
            $uID=$uID.Remove(0,4)   
            $uBulletinID=""   
            $uTitle=""
            $uDPLocality = $DPLocalityHash[$t.DPLocality.tostring()]
            $uPercentComplete = $t.PercentComplete
            $uStatus=$statusHash[$t.UpdateStatus.tostring()]
                    
            #query the update status from WMI
            $updateStatus = Get-WmiObject -Query "Select * from CCM_UpdateStatus where UniqueID = '$uID'" -Namespace root\ccm\SoftwareUpdates\UpdatesStore -Computer $ComputerName 
             foreach($u in $updateStatus)
             {
                $iMissing++
                $uBulletinID = $u.Bulletin
                #if there is no MS00-000 ID swap it for the KB article number
                if($uBulletinID -eq ""){$uBulletinID="KB$($u.Article)"}   
                $uTitle=$u.Title

             }
                #Write-Host "[$uBulletinID] :: [$uTitle]"

        [pscustomobject]@{  'BulletinId'= "$uBulletinID";
                            'Title' = $uTitle;
                            'Locality'= $uDPLocality; 
                            'PercentComplete' = $uPercentComplete; 
                            'Status'= $uStatus}
        #return $UpdatesMissing
        } 

    }  


}
