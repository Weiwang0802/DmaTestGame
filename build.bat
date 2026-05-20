@echo off
del /f /q "D:\Cheat\Code\PUBG PAOD\PAOD-PUBG-DMA-Source-Code-main\obj\x64\Release_Console\IronMan.Core-DMANo1\vc143.pdb" 2>nul
"C:\Program Files (x86)\Microsoft Visual Studio\2022\BuildTools\MSBuild\Current\Bin\MSBuild.exe" "D:\Cheat\Code\PUBG PAOD\PAOD-PUBG-DMA-Source-Code-main\IronMan.Core.sln" /p:Configuration=Release_Console /p:Platform=x64 /t:Build /m /v:minimal
pause
