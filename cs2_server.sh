#!/bin/bash

# Este script automatiza la instalación de SteamCMD y el servidor de CS2 en Ubuntu.

set -e

# Actualizar el sistema
echo "Actualizando el sistema..."
sudo apt update
sudo apt upgrade -y

# Instalar paquetes necesarios
echo "Instalando paquetes necesarios..."
sudo apt install -y wget curl tar lib32gcc-s1 lib32stdc++6

# Crear directorio para SteamCMD
echo "Creando directorio para SteamCMD..."
mkdir -p ~/steamcmd
cd ~/steamcmd

# Descargar y extraer SteamCMD
echo "Descargando SteamCMD..."
wget https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz
echo "Extrayendo SteamCMD..."
tar -xvzf steamcmd_linux.tar.gz

# Hacer SteamCMD ejecutable
echo "Haciendo SteamCMD ejecutable..."
chmod +x ~/steamcmd/linux32/steamcmd

# Crear directorio para el servidor de CS2
echo "Creando directorio para el servidor de CS2..."
mkdir -p ~/cs2_server

# Instalar el servidor de CS2 usando SteamCMD
echo "Instalando el servidor de CS2..."
# Asegúrate de reemplazar <app_id> con el ID correcto del servidor de CS2
APP_ID="<app_id>"
~/steamcmd/linux32/steamcmd +login anonymous +force_install_dir ~/cs2_server +app_update $APP_ID validate +quit

# Abrir puertos necesarios en el firewall
echo "Configurando el firewall..."
sudo ufw allow 27015/tcp
sudo ufw allow 27015/udp

# Mensaje de finalización
echo "La instalación se completó. Puedes iniciar el servidor de CS2 con el siguiente comando:"
echo "~/cs2_server/srcds_run -game cs2 -console -autoupdate +map de_dust2"

echo "¡Todo listo!"
