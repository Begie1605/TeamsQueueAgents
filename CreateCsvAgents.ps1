Import-Module "C:\\Program Files\\Common Files\\Skype for Business Online\\Modules\\SkypeOnlineConnector\\SkypeOnlineConnector.psd1"
# replace XXXX with password and next line with O365 user with rights 
$pw = convertto-securestring -AsPlainText -Force -String 'XXXXXX'
$cred = new-object -typename System.Management.Automation.PSCredential -argumentlist "xxxxxxxxxx@xxxxx",$pw


$CSSession = New-CsOnlineSession –Credential $cred
$output = Import-PSSession $CSSession –AllowClobber

New-Item TeamQueuesTemp.CSV -ItemType File -Force
Set-Content c:\temp\TeamQueuesTemp.CSV 'QueueName,Agents,OptinAgents,Optoutagents,AgentNames'
$queues = get-cscallqueue -NameFilter "BE"  -WarningAction silentlyContinue
foreach ($queue in $queues) {
$agents = $queue.agents
$OptinCount = 0
$OptinNames = ""
$OptoutCount = 0
$OptoutNames = "OPTOUT: "
foreach ($agent in $agents) {
$user = $agent.ObjectId | Get-CsOnlineUser
if ($agent.OptIn -eq "True") {
$OptinCount = $OptinCount + 1
$OptinNames = $OptinNames + $user.FirstName + " " + $user.LastName + " "
} else {
$OptoutCount = $OptoutCount + 1
$OptOutNames = $OptoutNames + $user.FirstName + " " + $user.LastName + " "
}
$agent | Add-Member -NotePropertyName Name -NotePropertyValue $user.alias
}
$CsvLine = $queue.Name + ',' + $agents.Count + ',' + $OptinCount + ',' + $OptinCount + ',' + $OptinNames
Add-Content c:\temp\TeamQueuesTemp.CSV $CsvLine
}
Move-Item -Path c:\temp\TeamQueuesTemp.CSV -destination c:\temp\TeamQueues.CSV -Force
Remove-PSSession $CSSession
