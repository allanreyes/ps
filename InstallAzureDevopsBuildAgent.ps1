$OrganizationName = "allanreyes-ms"
$Pool = "default"
$Agentname = $env:computername
$PAT = ""

Write-Output "Downloading custom build agent"
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls, [Net.SecurityProtocolType]::Tls11, [Net.SecurityProtocolType]::Tls12, [Net.SecurityProtocolType]::Ssl3
[Net.ServicePointManager]::SecurityProtocol = "Tls, Tls11, Tls12, Ssl3"
Invoke-WebRequest -Method Get -Uri "https://vstsagentpackage.azureedge.net/agent/2.195.2/vsts-agent-win-x64-2.195.2.zip" `
-OutFile "C:\agent.zip" 

Write-Output "Extracting agent.zip"
Add-Type -Assembly "System.IO.Compression.Filesystem"
[System.IO.Compression.ZipFile]::ExtractToDirectory('C:\agent.zip','C:\agent')


Write-Output "Configuring agent"
Set-Location "C:\agent"
$url = "https://dev.azure.com/$OrganizationName"
& .\config.cmd --unattended --url $url --auth pat --token $PAT --pool $Pool --agent $Agentname --replace --runAsService

Write-Output "Success"
