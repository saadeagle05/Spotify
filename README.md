<center>
    <h1 align="center">AdBlock Spotify</h1>
    <h4 align="center">Un bloqueador de anuncios para Spotify en WINDOWS.</h4>
    <h5 align="center">Apoya a Spotify comprando premium</h5>
</center>

#### Antes de instalar:
0. Actualice Windows, actualice Spotify y actualice este instalador
1. Vaya a "Seguridad de Windows" -> "Protección contra virus y amenazas"
2. Haga clic en "Amenazas permitidas" -> "Eliminar todas las amenazas permitidas"

### Caracteristicas:
* Bloquea todos los anuncios de banner/video/audio dentro de la aplicación
* Conserva la funcionalidad de amigo, video vertical y radio
* Desbloquea la función de saltar cualquier canción

:warning: Este bloqueador es para la versión de [**ESCRITORIO**](https://www.spotify.com/download/windows/) de Spotify en Windows y **no para la versión de microsoft store**.

### Instalación:
* Simplemente descarga y ejecuta [AdBlock Spotify.bat](https://raw.githack.com/5qw/5p0t1fy/master/AdBlock%20Spotify.bat)  

or

#### Instalación manual en powershell (comandos):

```powershell
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; Invoke-Expression "& { $(Invoke-WebRequest -UseBasicParsing 'https://raw.githubusercontent.com/5qw/Spotify/master/install.ps1') } -UninstallSpotifyStoreEdition -UpdateSpotify -RemoveAdPlaceholder"
```

#### Instalación manual:

1. Vaya a su carpeta de instalación de Spotify `%APPDATA%\Spotify`
2. Renombra `chrome_elf.dll` to `chrome_elf_bak.dll`. El nombre es importante.
3. Descarga `chrome_elf.zip` de [releases](https://github.com/5qw/Spotify/releases)
4. Descomprime `chrome_elf.dll` y `config.ini` a la carpeta de Spotify. 

### Desinstalación:
* Ejecutar [uninstall.bat](https://raw.githack.com/5qw/5p0t1fy/master/uninstall.bat)
or
* Desinstalar e instalar Spotify
