@echo off

rem
rem Uncomment setting VSCMD_DEBUG to enable debugging to output
rem
rem set VSCMD_DEBUG=3

rem
rem   Determine path to VsDevCmd.bat
rem

if not "%VsDevCmd_Path%x" == "x" (
    echo VsDevCmd_Path is already set to "%VsDevCmd_Path%", exiting
    goto :eof
)

for /f "usebackq delims=#" %%a in (`"%programfiles(x86)%\Microsoft Visual Studio\Installer\vswhere" -latest -property installationPath`) do set VsDevCmd_Path=%%a\Common7\Tools\VsDevCmd.bat
echo path is %VsDevCmd_Path%

if "%1x" == "32x" (
    echo using 32 bit
    "%VsDevCmd_Path%"
) else (
    echo using 64 bit
    "%VsDevCmd_Path%" -arch=amd64
)

set VsDevCmd_Path=
