[string[]]$nsvals="1.1.1.1","1.0.0.1","8.8.8.8","8.8.4.4","180.250.13.42","180.250.13.46"
$Domaincheck="indihome.co.id"
$outputfile="C:\Test1\process.txt"
foreach ($element in $nsvals) {
    measure-command{nslookup $Domaincheck $element}|select TotalSeconds | Out-File -filepath $outputfile -Append
}