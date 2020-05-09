@echo off
setlocal enabledelayedexpansion

if "%1x"=="x" (
    echo %0 ERROR: usage %0 iis_script hosts_file
    exit /b
)

if "%2x"=="x" (
    echo %0 ERROR: usage %0 iis_script hosts_file
    exit /b
)

if "%solution%x"=="x" (
    echo %0 ERROR: solution variable not set
    exit /b
)

if "%domain%x"=="x" (
    echo %0 ERROR: domain variable not set
    exit /b
)

if "%environment%x"=="x" (
    echo %0 ERROR: environment variable not set
    exit /b
)

if "%webapp%x"=="x" (
    echo %0 ERROR: webapp variable not set
    exit /b
)

if "%iis_solution_physical_path_root%x"=="x" (
    echo %0 ERROR: iis_solution_physical_path_root variable not set
    exit /b
)

set iis_script=%1
set hosts_file=%2
set app_cmd=%WINDIR%\system32\inetsrv\appcmd.exe

call :create_web_site_script
call :create_hosts_section

goto :eof

:create_web_site_script

if "%webapp%x"=="uix" (
    set sub_domain=%environment%-%solution%
) else (
    set sub_domain=%environment%-%webapp%-%solution%
)

set site_name=%environment%-%solution%-%webapp%-%domain%
set host_name=%sub_domain%.%domain%
set physical_path=%iis_solution_physical_path_root%\%vsproject%

set site_bindings=%host_name%

echo %app_cmd% delete site %site_name% >> %iis_script%
echo %app_cmd% delete apppool %site_name% >> %iis_script%

echo %app_cmd% add apppool /name:"%site_name%" /managedRuntimeVersion:"" -processModel.identityType:LocalSystem >> %iis_script%
echo %app_cmd% add site /name:"%site_name%" /site.name:"%site_name%" /bindings:"http://%site_bindings%:80" /physicalPath:"%physical_path%" >> %iis_script%
echo %app_cmd% set app "%site_name%/" /applicationPool:"%site_name%" >> %iis_script%
echo %app_cmd% start apppool /apppool.name:"%site_name%" >> %iis_script%
echo. >> %iis_script%

exit /b

:create_hosts_section

set info=SOLUTION: %solution%, ENVIRONMENT: %environment%, WEBAPP: %webapp%

echo # %info% >> %hosts_file%

echo # Site name:        %site_name% >> %hosts_file%
echo # Application pool: %site_name% >> %hosts_file%
echo # Physical path:    %physical_path% >> %hosts_file%
echo 127.0.0.1           %host_name% >> %hosts_file%

echo. >> %hosts_file%

exit /b