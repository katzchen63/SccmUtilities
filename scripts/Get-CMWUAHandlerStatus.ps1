# 
# NAME
#     Get-CMWUAHandlerStatus
#     
# SYNTAX
#     Get-CMWUAHandlerStatus [[-StartTime] <datetime>]  
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
function Get-CMWUAHandlerStatus 
{

    param([datetime]$StartTime = ((get-date).addhours(-7)))
    #l, that error code will be returned from a line in another log called WUAHandler.log
    #and when it happens, it looks like this
    #Async searching completed.	WUAHandler	3/6/2018 6:13:25 PM	2460 (0x099C)
    #OnSearchComplete - Failed to end search job. Error = 0x80244010.	WUAHandler	3/6/2018 6:13:25 PM	2936 (0x0B78)
    #Scan failed with error = 0x80244010.	WUAHandler	3/6/2018 6:13:25 PM	2936 (0x0B78) 
    $return = Get-cmlog -Path 'C:\windows\ccm\logs\WuaHandler.log' |Where-Object{$_.localtime -gt $StartTime}
    $return


}
