[string[]]$nsvals="208.67.222.222","208.67.220.220","1.1.1.1","1.0.0.1","8.8.8.8","8.8.4.4","180.250.13.42","180.250.13.46"
$Domaincheck="telkom.net" 
#the user isp domain are telkom.net, testing that instead?
#$outputfile="C:\Test1\process.txt"
#Write-Debug "Directory - $($outputfile) - not found."
$dirout="C:\Test1"
if (!(test-path $dirout)) {
    #create directory if not exist
    New-Item -ItemType Directory -Force -Path $dirout
    Write-Host "Directory -$($dirout) - created"
}
For ($i=0; $i -le 999; $i++) {
	
	foreach ($element in $nsvals) {
        #uncomment to enable verbose output and output txt file (this will affect the result as it is differ from csv file and the txt TotalSeconds, 
        #guess its also count the system executing script too) 
        Write-Host $i
        #$i | Out-File $outputfile -Append
        Write-Host $element
        #$element | Out-File $outputfile -Append
        $testnamesrv= Resolve-DnsName $DomainCheck -Type SRV -Server $element
		#Measure-Command{nslookup $Domaincheck 2>$null $element} | Select TotalSeconds | Out-File -filepath $outputfile -Append 
        <# added 2>$null to avoid output display error 
        https://superuser.com/questions/1253297/nslookup-in-powershell-always-throws-remoteexception-error
        #>
        
        $expthiscsv = [PSCustomObject]@{
            Number=($i)+1;
            Date=Get-Date -format "dd/MMM/yyyy HH:mm:ss tt";
            DomainName=$Domaincheck;
            NameAdministrator=$testnamesrv|Select -ExpandProperty NameAdministrator;
            NameServer=$element;
            ResolveTime=Measure-Command{$testnamesrv}|Select -ExpandProperty TotalSeconds;
        }
        $expthiscsv | Select Number,Date,DomainName,NameAdministrator,NameServer,ResolveTime | Export-Csv -Path $dirout\process.csv -NoTypeInformation -Append
    }
	
}
<# further improvement/feature to be add in the script:
1. set the DNS in modem/router and run Benchmark-Command{ping -n 1 example-domain.com} -Sample 50 to each DNS that is set
2.
3.

#>