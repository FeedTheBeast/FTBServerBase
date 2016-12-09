#!/bin/sh

cd "$(dirname "$0")"
. ./settings.sh

mkdir -p $(dirname libraries/${LAUNCHWRAPPER})

which wget
if [ $? -eq 0 ]; then
        wget -O ${JARFILE} https://s3.amazonaws.com/Minecraft.Download/versions/${MCVER}/${JARFILE}
        wget -O libraries/${LAUNCHWRAPPER} https://libraries.minecraft.net/${LAUNCHWRAPPER}
else
        which curl
        if [ $? -eq 0 ]; then
                curl -o ${JARFILE} https://s3.amazonaws.com/Minecraft.Download/versions/${MCVER}/minecraft_server.${MCVER}.jar
        		curl -o libraries/${LAUNCHWRAPPER} https://libraries.minecraft.net/${LAUNCHWRAPPER}
        else
                echo "Neither wget or curl were found on your system. Please install one and try again"
        fi
fi
