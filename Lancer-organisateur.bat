@echo off
setlocal
rem Ouvre l'organisateur dans une fenetre Chrome/Edge dediee, ou le glisser-deposer de dossiers fonctionne.
rem - Profil separe : fonctionne meme si Chrome est deja ouvert, sans toucher a votre Chrome habituel.
rem - Le profil (et donc la sauvegarde des photos) est range dans %LOCALAPPDATA%, jamais dans ce dossier :
rem   rien de personnel ne part sur GitHub.

set "PAGE=%~dp0index.html"
set "PROFILE=%LOCALAPPDATA%\OrganisateurFeed\profil-navigateur"
set "BROWSER="

call :try "%ProgramFiles%\Google\Chrome\Application\chrome.exe"
call :try "%ProgramFiles(x86)%\Google\Chrome\Application\chrome.exe"
call :try "%LocalAppData%\Google\Chrome\Application\chrome.exe"
call :try "%ProgramFiles(x86)%\Microsoft\Edge\Application\msedge.exe"
call :try "%ProgramFiles%\Microsoft\Edge\Application\msedge.exe"

if not defined BROWSER goto notfound
if not exist "%PAGE%" goto nopage

start "" "%BROWSER%" --user-data-dir="%PROFILE%" --allow-file-access-from-files --no-first-run --no-default-browser-check --app="%PAGE%"
exit /b 0

:try
if not defined BROWSER if exist "%~1" set "BROWSER=%~1"
exit /b 0

:notfound
echo Google Chrome ou Microsoft Edge est introuvable sur cet ordinateur.
echo Ouvrez simplement index.html et utilisez le bouton "Parcourir" pour les dossiers.
pause
exit /b 1

:nopage
echo index.html est introuvable : gardez ce fichier .bat dans le meme dossier que index.html.
pause
exit /b 1
