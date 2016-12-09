call settings.bat

mkdir libraries\net\minecraft\launchwrapper\%LAUNCHWRAPPERVERSION%

libraries\wget.exe -O %JARFILE% https://s3.amazonaws.com/Minecraft.Download/versions/%MCVER%/%JARFILE%
libraries\wget.exe -O libraries\%LAUNCHWRAPPER% https://libraries.minecraft.net/net/minecraft/launchwrapper/%LAUNCHWRAPPERVERSION%/launchwrapper-%LAUNCHWRAPPERVERSION%.jar
