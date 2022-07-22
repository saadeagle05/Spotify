## <p align="center"> 🔰 AdBlock Spotify 🔰</p>
<!--<p align="center">:warning: Este bloqueador es UNICAMENTE para la versión de <a href="https://www.spotify.com/download/windows/">ESCRITORIO</a> de Spotify </a></p>-->
<p align="center"><a href="https://www.spotify.com/premium/">💲 Apoya a Spotify comprando premium 💲</a> </p>

<p align="center"> <img src="https://img.shields.io/github/stars/5qw/Spotify?label=Stars"> <img src="https://img.shields.io/badge/license-MIT-green.svg?label=License"> </p>

## 🧩 » <b> Información: </b>
Este repositorio contiene los archivos necesarios para bloquear anuncios en Spotify. El dueño del repositorio no se hace responsable de ninguna consecuencia que le ocurra al usuario que use este programa. <br> Características que se ofrecen:
* Bloquea todos los anuncios de banner/video/audio dentro de la aplicación
* Conserva la funcionalidad de amigo, video vertical y radio
* Desbloquea la función de saltar cualquier canción

## 🧱 » <b> Antes de instalar (opcional): </b>
1. Actualice Windows, actualice Spotify y actualice este instalador
2. Vaya a "Seguridad de Windows" ➞ "Protección contra virus y amenazas"
3. Haga clic en "Amenazas permitidas" ➞ "Eliminar todas las amenazas permitidas"

## ⚙️ » <b> Instalación recomendada:</b>
* Simplemente [descarga la ultima versión](https://github.com/5qw/Spotify/releases/latest/download/Spotify.rar) y ejecuta `AdBlock Spotify.bat`. 

## 🔩 » <b> Instalación manual (comandos):</b>

```powershell
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; Invoke-Expression "& { $(Invoke-WebRequest -UseBasicParsing 'https://raw.githubusercontent.com/5qw/Spotify/master/install.ps1') } -UninstallSpotifyStoreEdition -UpdateSpotify -RemoveAdPlaceholder"
```

## ⛏ » <b> Instalación manual (archivos): </b>

1. Vaya a su carpeta de instalación de Spotify `%APPDATA%\Spotify`
2. Renombra `chrome_elf.dll` to `chrome_elf_bak.dll`. El nombre es importante.
3. Descarga `chrome_elf.zip` de [releases](https://github.com/5qw/Spotify/releases)
4. Descomprime `chrome_elf.dll` y `config.ini` a la carpeta de Spotify. 

## 📦 » <b> Desinstalación: </b>
* Ejecutar [uninstall.bat](https://raw.githack.com/5qw/Spotify/master/uninstall.bat)
* Desinstalar e instalar Spotify
