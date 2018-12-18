[string[]]$nsvals="208.67.222.222","208.67.220.220","1.1.1.1","1.0.0.1","8.8.8.8","8.8.4.4","180.250.13.42","180.250.13.46"
$Domaincheck="telkom.net" 
#the user isp domain are telkom.net, testing that instead?
$outputfile="C:\Test1\process.txt"
#Write-Debug "Directory - $($outputfile) - not found."
$dirout="C:\Test1"
if (!(test-path $dirout)) {
    #create directory if not exist
    New-Item -ItemType Directory -Force -Path $dirout
    Write-Host "Directory -$($dirout) - created"
}
For ($i=0; $i -le 999; $i++) {
	
	foreach ($element in $nsvals) {
        Write-Host $i
        $i | Out-File $outputfile -Append
        Write-Host $element
        $element | Out-File $outputfile -Append
		Measure-Command{nslookup $Domaincheck 2>$null $element}|select TotalSeconds | Out-File -filepath $outputfile -Append 
        <# added 2>$null to avoid output display error 
        https://superuser.com/questions/1253297/nslookup-in-powershell-always-throws-remoteexception-error
        #>
    }
	
}
<# further improvement/feature to be add in the script:
1.
2.
3.

#>