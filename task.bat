@echo off
:: Get the system datetime
set CURRENT_YEAR=%DATE:~6,4%
set CURRENT_DATETIME=%TIME:~0,5% %DATE:~0,2%/%DATE:~3,2%/%DATE:~6,4%

:: Set the download URL with the current year
set ZIP_URL=https://www.cftc.gov/files/dea/history/deacot%CURRENT_YEAR%.zip
set ZIP_FILE=deacot%CURRENT_YEAR%.zip
set EXTRACT_DIR=.

:: Download the zip file
echo Downloading %ZIP_FILE% from %ZIP_URL%...
del %ZIP_FILE%
curl -L -o %ZIP_FILE% %ZIP_URL%

:: Extract the zip file
echo Extracting %ZIP_FILE%...
tar -xf %ZIP_FILE% -C %EXTRACT_DIR%

:: Delete the zip file
echo Deleting %ZIP_FILE%...
del %ZIP_FILE%

:: Add changes to Git
git add .
git commit -m "%CURRENT_DATETIME%"
git push origin main

echo Process Completed!
@REM exit
