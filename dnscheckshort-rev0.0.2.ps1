﻿[string[]]$nsvals="1.1.1.1","1.0.0.1","8.8.8.8","8.8.4.4","180.250.13.42","180.250.13.46"
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
foreach ($element in $nsvals) {
    #measure-command{nslookup $Domaincheck 2>$null $element}|select TotalSeconds | Out-File -filepath $outputfile -Append
    <# added 2>$null to avoid output display error 
        https://superuser.com/questions/1253297/nslookup-in-powershell-always-throws-remoteexception-error
        #>
    $testnamesrv= Resolve-DnsName $DomainCheck -Type SRV -Server $element
    $expthiscsv = [PSCustomObject]@{
        #Number=($i)+1;
        Date=Get-Date -format "dd/MMM/yyyy HH:mm:ss tt";
        DomainName=$Domaincheck;
        NameAdministrator=$testnamesrv|Select -ExpandProperty NameAdministrator;
        NameServer=$element;
        ResolveTime=Measure-Command{$testnamesrv}|Select -ExpandProperty TotalSeconds;
    }
    $expthiscsv | Select Date,DomainName,NameAdministrator,NameServer,ResolveTime | Export-Csv -Path $dirout\process.csv -NoTypeInformation -Append
}