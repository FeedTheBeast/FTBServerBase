#!/bin/sh

# Fix work directory
# Some GUIs set wrong working directory which breaks relative paths
cd -- "$(dirname "$0")"

# makes things easier if script needs debugging
if [ x${FTB_VERBOSE} = xyes ]; then
    set -x
fi

# Read pack related settings from external setting file
. ./settings.sh

# Read settings defined by local server admin
if [ -f settings-local.sh ]; then
    . ./settings-local.sh
fi

# cleaner code
eula_false() {
    grep -q 'eula=false' eula.txt
    return $?
}

# cleaner code 2
start_server() {
    "$JAVACMD" -server -Xmx${MAX_RAM} ${JAVA_PARAMETERS} -jar ${FORGEJAR} nogui
}

# run install script if MC server or launchwrapper s missing
if [ ! -f ${JARFILE} -o ! -f libraries/${LAUNCHWRAPPER} ]; then
    echo "Missing required jars. Running install script!"
    sh ./FTBInstall.sh
fi

# check eula.txt
if [ -f eula.txt ] && eula_false ; then
    echo "Make sure to read eula.txt before playing!"
    echo "To exit press <enter>"
    read ignored
    exit
fi

# if eula.txt is missing inform user and start MC to create eula.txt
if [ ! -f eula.txt ]; then
    echo "Missing eula.txt. Startup will fail and eula.txt will be created"
    echo "Make sure to read eula.txt before playing!"
    echo "To continue press <enter>"
    read ignored
fi

echo "Starting server"
rm -f autostart.stamp
start_server

while [ -e autostart.stamp ] ; do
    rm -f autostart.stamp
    echo "If you want to completely stop the server process now, press Ctrl+C before the time is up!"
    for i in 5 4 3 2 1; do
        echo "Restarting server in $i"
        sleep 1
    done
    echo "Rebooting now!"
    start_server
    echo "Server process finished"
done

