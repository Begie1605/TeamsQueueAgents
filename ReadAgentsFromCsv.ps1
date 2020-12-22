param (
    [string]$queuename = 'XXXXXXX'
 )
$A = Import-csv -Path c:\temp\TeamQueues.CSV
$B = $A | Where-object -Property QueueName -EQ $queuename
Write-Host "<?xml version="1.0" encoding="UTF-8" ?>"
Write-Host "<prtg>"
foreach ($i in $b) {
Write-Host "<result>"
                "<channel>Agents</channel>"
                "<float>0</float>"
                "<value>"+ $i.Agents+"</value>"
           "</result>"
Write-Host "<result>"
                "<channel>OptIN Agents</channel>"
                "<float>0</float>"
                "<value>" + $i.OptinAgents +"</value>"
           "</result>"
Write-Host "<result>"
                "<channel>OptOUT Agents</channel>"
                "<float>0</float>"
                "<value>" + $i.Optoutagents +"</value>"
           "</result>"
    }

Write-Host  "<text>" $i.AgentNames "</text>"
Write-Host "</prtg>"

