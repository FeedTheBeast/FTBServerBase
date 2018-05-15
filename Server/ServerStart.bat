@if NOT "%FTB_VERBOSE%"=="yes" (
    @echo off
)

call settings.bat

if NOT EXIST %JARFILE% (
    goto install
)
if NOT EXIST libraries\%LAUNCHWRAPPER% (
    goto install
)
goto skipinstall

:install
echo running install script!
call FTBInstall.bat
:skipinstall

REM Check if java in path
REM TODO: use %JAVACMD%
where java > NUL 2>&1

if %ERRORLEVEL% NEQ 0 (
    echo No java binary in path. Can't run server, exiting...
    pause
    exit /B
)

REM Test JVM
REM e.g. 32-bit JVM does not have server\jvm.dll library
java -server -version > java-test.log 2>&1

if %ERRORLEVEL% NEQ 0 (
    echo Detected following JVM error:
    echo =======================================
    more java-test.log
    echo =======================================
    echo JVM test failed. Can't run server, Exiting...
    pause
    exit /B
)

if not exist eula.txt (
    echo Missing eula.txt. Startup will fail and eula.txt will be created
    echo Make sure to read eula.txt before playing!
    goto startserver
)

find "eula=false" eula.txt 1 > NUL 2>&1
if %ERRORLEVEL% EQU 0 (
    echo Make sure to read eula.txt before playing! Exiting.
    pause
    exit /B
)

del /f /q autostart.stamp > nul 2>&1

:startserver
echo Starting server
java -server -Xmx%MAX_RAM% -XX:PermSize=%PERMGEN_SIZE% %JAVA_PARAMETERS% -jar %FORGEJAR% nogui

:server_loop
if exist autostart.stamp (
    del /f /q autostart.stamp > nul 2>&1
    echo If you want to completely stop the server process now, press Ctrl+C before the time is up!
    for /l %%i in (5,-1,1) do (
        echo Restarting server in %%i
        choice /t 1 /d y > nul
    )
    echo Starting server now
    java -server -Xmx%MAX_RAM% %JAVA_PARAMETERS% -jar %FORGEJAR% nogui
    echo Server process finished
    goto :server_loop
)
echo Exiting...
pause
