rem Do not touch
set MCVER=*MCVERSION*
set JARFILE=minecraft_server.%MCVER%.jar
set LAUNCHWRAPPERVERSION=1.12
set LAUNCHWRAPPER=net\minecraft\launchwrapper\%LAUNCHWRAPPERVERSION%\launchwrapper-%LAUNCHWRAPPERVERSION%.jar
set FORGEJAR=*SERVERJAR*

rem can be changed by user
set MIN_RAM=512M
set MAX_RAM=2048M
set PERMGEN_SIZE=256M
set JAVA_PARAMETERS=-XX:+UseParNewGC -XX:+CMSIncrementalPacing -XX:+CMSClassUnloadingEnabled -XX:ParallelGCThreads=2 -XX:MinHeapFreeRatio=5 -XX:MaxHeapFreeRatio=10