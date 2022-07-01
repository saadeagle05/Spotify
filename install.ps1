# Ignore errors from `Stop-Process`
$PSDefaultParameterValues['Stop-Process:ErrorAction'] = 'SilentlyContinue'

write-host @'
***************** 
Mensaje de @xyz
Paga el spotify rata.
***************** 
'@

write-host @'
***************** 
Autor: @xyz
***************** 
'@

$SpotifyDirectory = "$env:APPDATA\Spotify"
$SpotifyExecutable = "$SpotifyDirectory\Spotify.exe"
$SpotifyApps = "$SpotifyDirectory\Apps"

Write-Host 'Deteniendo Spotify...'`n
Stop-Process -Name Spotify
Stop-Process -Name SpotifyWebHelper

if ($PSVersionTable.PSVersion.Major -ge 7)
{
    Import-Module Appx -UseWindowsPowerShell
}

if (Get-AppxPackage -Name SpotifyAB.SpotifyMusic) {
  Write-Host @'
La version de la Microsoft Store ha sido detectada y es incompatible.
'@`n
  $ch = Read-Host -Prompt "Desinstalar esta version (S/N) "
  if ($ch -eq 's'){
     Write-Host @'
Desinstalando...
'@`n
     Get-AppxPackage -Name SpotifyAB.SpotifyMusic | Remove-AppxPackage
  } else{
     Write-Host @'
Saliendo...
'@`n
     Pause 
     exit
    }
}

Push-Location -LiteralPath $env:TEMP
try {
  # Unique directory name based on time
  New-Item -Type Directory -Name "SpotifyAAD-$(Get-Date -UFormat '%Y-%m-%d_%H-%M-%S')" `
  | Convert-Path `
  | Set-Location
} catch {
  Write-Output $_
  Pause
  exit
}

Write-Host 'Descargando el ultimo bloqueador disponible...'`n
$webClient = New-Object -TypeName System.Net.WebClient
try {
  $webClient.DownloadFile(
    # Remote file URL
    'https://github.com/mrpond/BlockTheSpot/releases/latest/download/chrome_elf.zip',
    # Local file path
    "$PWD\chrome_elf.zip"
  )
} catch {
  Write-Output $_
  Sleep
}
<#
try {
  $webClient.DownloadFile(
    # Remote file URL
    'https://github.com/mrpond/BlockTheSpot/files/5969916/zlink.zip',
    # Local file path
    "$PWD\zlink.zip"
  )
} catch {
  Write-Output $_
  Sleep
}
try {
  $webClient.DownloadFile(
    # Remote file URL
    'https://github.com/mrpond/BlockTheSpot/files/6234124/xpui.zip',
    # Local file path
    "$PWD\xpui.zip"
  )
} catch {
  Write-Output $_
  Sleep
}
#>
Expand-Archive -Force -LiteralPath "$PWD\chrome_elf.zip" -DestinationPath $PWD
Remove-Item -LiteralPath "$PWD\chrome_elf.zip"
<#
Expand-Archive -Force -LiteralPath "$PWD\zlink.zip" -DestinationPath $PWD
Remove-Item -LiteralPath "$PWD\zlink.zip"
Expand-Archive -Force -LiteralPath "$PWD\xpui.zip" -DestinationPath $PWD
Remove-Item -LiteralPath "$PWD\xpui.zip"
#>
$spotifyInstalled = (Test-Path -LiteralPath $SpotifyExecutable)
if (-not $spotifyInstalled) {
  Write-Host @'
Spotify no esta instalado en este equipo.
Descargando e instalando Spotify, espere...
'@
  try {
    $webClient.DownloadFile(
      # Remote file URL
      'https://download.scdn.co/SpotifyFullSetup.exe',
      # Local file path
      "$PWD\SpotifyFullSetup.exe"
    )
  } catch {
    Write-Output $_
    Pause
    exit
  }
  mkdir $SpotifyDirectory >$null 2>&1
  Write-Host 'Running installation...'
  Start-Process -FilePath "$PWD\SpotifyFullSetup.exe"
  Write-Host 'Stopping Spotify...Again'
  while ((Get-Process -name Spotify -ErrorAction SilentlyContinue) -eq $null){
     #waiting until installation complete
     }
  Stop-Process -Name Spotify >$null 2>&1
  Stop-Process -Name SpotifyWebHelper >$null 2>&1
  Stop-Process -Name SpotifyFullSetup >$null 2>&1
}

if (!(test-path $SpotifyDirectory/chrome_elf_bak.dll)){
	move $SpotifyDirectory\chrome_elf.dll $SpotifyDirectory\chrome_elf_bak.dll >$null 2>&1
}

Write-Host 'Arreglando Spotify...'
$patchFiles = "$PWD\chrome_elf.dll", "$PWD\config.ini"
<#
$remup = "$PWD\zlink.spa"
$uipat = "$PWD\xpui.spa"
#>
Copy-Item -LiteralPath $patchFiles -Destination "$SpotifyDirectory"
<#
$ch = Read-Host -Prompt "Optional - Remove Upgrade Button. (Y/N) "
if ($ch -eq 'y'){
    move $SpotifyApps\zlink.spa $SpotifyApps\zlink.spa.bak >$null 2>&1
    Copy-Item -LiteralPath $remup -Destination "$SpotifyApps"
} else{
     Write-Host @'
Won't remove Upgrade Button.
'@`n
}

$ch = Read-Host -Prompt "Change Alpha UI back to Old UI. (BTS only supports Old UI). (Y/N) "
if ($ch -eq 'y'){
    move $SpotifyApps\xpui.spa $SpotifyApps\xpui.spa.bak >$null 2>&1
    Copy-Item -LiteralPath $uipat -Destination "$SpotifyApps"
} else{
     Write-Host @'
UI isn't changed.
'@`n
}
#>

$ch = Read-Host -Prompt "Opcional - Quitar diseño de anuncios y boton de compra. Indique 'N' si estas usando un cliente custom (S/N) "
if ($ch -eq 's') {
    Add-Type -Assembly 'System.IO.Compression.FileSystem'

    Copy-Item -Path "$SpotifyApps\xpui.spa" -Destination "$SpotifyApps\xpui.spa.bak"

    $zip = [System.IO.Compression.ZipFile]::Open("$SpotifyApps\xpui.spa", 'update')
    $entry = $zip.GetEntry('xpui.js')

    # Extract xpui.js from zip to memory
    $reader = New-Object System.IO.StreamReader($entry.Open())
    $xpuiContents = $reader.ReadToEnd()
    $reader.Close()

    # Replace ".ads.leaderboard.isEnabled" + separator - '}' or ')'
    # With ".ads.leaderboard.isEnabled&&false" + separator
    $xpuiContents = $xpuiContents -replace '(\.ads\.leaderboard\.isEnabled)(}|\))', '$1&&false$2'
    
    # Delete ".createElement(XX,{onClick:X,className:XX.X.UpgradeButton}),X()"
    $xpuiContents = $xpuiContents -replace '\.createElement\([^.,{]+,{onClick:[^.,]+,className:[^.]+\.[^.]+\.UpgradeButton}\),[^.(]+\(\)', ''
    
    # Rewrite it to the zip
    $writer = New-Object System.IO.StreamWriter($entry.Open())
    $writer.BaseStream.SetLength(0)
    $writer.Write($xpuiContents)
    $writer.Close()

    $zip.Dispose()
} else {
     Write-Host @'
No se quitara el diseño de anuncios y boton de compra.
'@`n
}

$tempDirectory = $PWD
Pop-Location

Remove-Item -Recurse -LiteralPath $tempDirectory  

Write-Host 'Proceso terminado, abriendo Spotify...'
Start-Process -WorkingDirectory $SpotifyDirectory -FilePath $SpotifyExecutable
Write-Host 'Listo.'

write-host @'
***************** 
Mensaje de @xyz:
Ya tienes Spotify sin anuncios.
***************** 
'@

exit
