[string[]]$nsvals="208.67.222.222","208.67.220.220","1.1.1.1","1.0.0.1","8.8.8.8","8.8.4.4","180.250.13.42","180.250.13.46"
$Domaincheck="indihome.co.id"
$outputfile="C:\Test1\process.txt"
For ($i=0; $i -le 999; $i++) {
	
	foreach ($element in $nsvals) {
        Write-Host $i
        $i | Out-File $outputfile -Append
        Write-Host $element
        $element | Out-File $outputfile -Append
		measure-command{nslookup $Domaincheck $element}|select TotalSeconds | Out-File -filepath $outputfile -Append
	}
	
}