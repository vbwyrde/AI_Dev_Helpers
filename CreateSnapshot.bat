@echo off
setlocal enabledelayedexpansion

pause

rem Check parameters
if "%~1"=="" (
    echo Usage: CreateSnapshot.bat ProjectName "FileExtensions" SourcePath
    echo Example: CreateSnapshot.bat MyProject ".vb,.css,.aspx" "C:\inetpub\wwwroot\PvAChess"
    exit /b 1
)

set PROJECT_NAME=%~1
set FILE_TYPES=%~2
set SOURCE_DIR=%~3

rem Remove quotes from file types if present
set FILE_TYPES=%FILE_TYPES:"=%

rem Create Projects folder if it doesn't exist
if not exist "%~dp0Projects" mkdir "%~dp0Projects"

rem Create project folder if it doesn't exist
if not exist "%~dp0Projects\%PROJECT_NAME%" mkdir "%~dp0Projects\%PROJECT_NAME%"

rem Get next CM number
set MAX_NUM=-1
for /d %%i in ("%~dp0Projects\%PROJECT_NAME%\CM_*") do (
    set "FOLDER=%%~nxi"
    echo Processing folder: !FOLDER!
    set "NUM=!FOLDER:~3,5!"
    
    rem Strip leading zeros
    for /f "tokens=* delims=0" %%n in ("!NUM!") do set NUM=%%n
    if "!NUM!"=="" set NUM=0
    
    set /a "TEST_NUM=!NUM!"
    if !TEST_NUM! gtr !MAX_NUM! (
        set "MAX_NUM=!TEST_NUM!"
    )
)
set /a NEXT_NUM=MAX_NUM+1

rem Format CM folder name with leading zeros properly
call :PadNumber !NEXT_NUM!
echo Creating folder: !NEW_FOLDER!

rem Create new CM folder
mkdir "%~dp0Projects\%PROJECT_NAME%\!NEW_FOLDER!"

rem Copy matching files, preserving directory structure
for %%e in (%FILE_TYPES:.=%) do (
    echo Copying *%%e files...
    xcopy "%SOURCE_DIR%\*.%%e" "%~dp0Projects\%PROJECT_NAME%\!NEW_FOLDER!" /s /i
)

echo.
echo Snapshot created in: %~dp0Projects\%PROJECT_NAME%\!NEW_FOLDER!
echo.
pause
exit /b

:PadNumber
set "NUM=%1"
set "PADDED=0000%NUM%"
set "NEW_FOLDER=CM_%PADDED:~-5%"
exit /b 