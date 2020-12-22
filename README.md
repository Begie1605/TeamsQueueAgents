# TeamsQueueAgents
PRTG custom sensor to display agent opt in on a MS teams queue


#Get stats
CreateCsvAgents.ps1 : schedule this powershell to run every x time via task scheduler
- creates file in c:\temp

#Prtg XML/advanced sensor
- create sensor
- file = ReadAgentsFromCsv.ps1
- param = queu name of teams

result is channel:
- number of agents
- number of optin agents
- number of optout agents
- names of optin agents as message


#  additional add file sensor on file C:\temp\TeamQueues.csv to check file is generated every x time (alert on modified date)
