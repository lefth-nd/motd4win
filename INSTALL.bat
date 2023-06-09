@echo off

set "folderName=motd4win"

set "appDataPath=%USERPROFILE%\AppData\Local"

mkdir "%appDataPath%\%folderName%"

echo Folder created: "%appDataPath%\%folderName%"

set "distPath=%appDataPath%\%folderName%"

cp motd.py "%distPath%"

echo "copied script to %distPath%"

pip install -r requirements.txt

:: exe not needed yet
:: pip install pyinstaller
:: pyinstaller --onefile --distpath %appDataPath%\%folderName% motd.py
 
for /f "delims=" %%I in ('powershell -command "if (Test-Path $PROFILE) { Write-Output 'True' } else { Write-Output 'False' }"') do set "profileExists=%%I"

echo %profileExists%

if %profileExists% == True (
	:: powershell -command "Add-Content -Path $PROFILE -Value 'Start-process -FilePath %distPath%\motd.exe'"
	powershell -command "Add-Content -Path $PROFILE -Value 'python %distPath%\motd.py'"
) else (
	powershell -command "New-Item -path $PROFILE -type file -force"
	powershell -command "Add-Content -Path $PROFILE -Value 'python %distPath%\motd.py'"
)
