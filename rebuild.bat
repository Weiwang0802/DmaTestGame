@echo off
echo Cleaning build artifacts...
del /f /s /q "D:\Cheat\Code\PUBG PAOD\PAOD-PUBG-DMA-Source-Code-main\obj\x64\Release_Console\*.*" 2>nul
del /f /q "D:\Cheat\Code\PUBG PAOD\PAOD-PUBG-DMA-Source-Code-main\bin\x64\Release_Console\Paod.exe" 2>nul
del /f /q "D:\Cheat\Code\PUBG PAOD\PAOD-PUBG-DMA-Source-Code-main\bin\x64\Release_Console\*.pdb" 2>nul
echo Building...
"C:\Program Files (x86)\Microsoft Visual Studio\2022\BuildTools\MSBuild\Current\Bin\MSBuild.exe" "D:\Cheat\Code\PUBG PAOD\PAOD-PUBG-DMA-Source-Code-main\IronMan.Core.sln" /p:Configuration=Release_Console /p:Platform=x64 /t:Build /m /v:minimal
echo Exit code: %ERRORLEVEL%
if %ERRORLEVEL%==0 (echo BUILD SUCCESS!) else (echo BUILD FAILED!)
pause
