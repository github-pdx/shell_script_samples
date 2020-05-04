@echo off
cd /d %~dp0
TITLE %~dpnx0
echo Written by: github.pdx

@SETLOCAL
@SET drv=%~d0
@SET pth=%~p0
@SET fpath=%~dp0
@SET fname=%~n0
@SET ext=%~x0
echo Running: %fpath%%fname%%ext%

@SET SYNAPSE_PATH="C:\Users\%USERNAME%\AppData\Local\Fujifilm Medical Systems\Synapse"
@SET SYNAPSE_STATION="C:\Users\%USERNAME%\AppData\Local\Fujifilm Medical Systems\Synapse\Workstation"
@SET SYNAPSE_DOC="C:\Users\%USERNAME%\AppData\Local\Fujifilm Medical Systems\Synapse\EnterpriseDocstore"

echo fixing corrupt Synapse workstation settings...
echo for %USERNAME% 
echo on %COMPUTERNAME% 
echo %DATE% %TIME%

DIR %SYNAPSEPATH%
taskkill /f /IM explorer.exe
timeout /t 2 > nul

if exist %SYNAPSE_STATION% RMDIR /s /q %SYNAPSE_STATION%
if exist %SYNAPSE_DOC% RMDIR /s /q %SYNAPSE_DOC%
if exist %SYNAPSE_PATH% RMDIR /s /q %SYNAPSE_PATH%

echo Restarting Windows Explorer...
start explorer.exe
timeout /t 2 > nul
if exist %SYNAPSE_DOC% RMDIR /s /q %SYNAPSE_DOC%

echo. 
echo RESTARTING WORKSTATION

echo.
echo %fpath%%fname%%ext% complete...
@ENDLOCAL
timeout /t 5 > nul

C:\Windows\System32\shutdown.exe /r /t 0
