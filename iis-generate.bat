@echo off
setlocal enabledelayedexpansion

set app_cmd=%WINDIR%\system32\inetsrv\appcmd.exe

::set iis_script=scripts\create_iis_sites.bat
::set domain=example.com
::set host_name=%domain%
::set app=TestApi
::set env=local-
::call :create_web_site

call :create_web_site_script

call :create_hosts_section

goto :eof

:create_web_site_script
if "%webapp%x"=="uix" (
    set sub_domain=%environment%-%solution%
) else (
    set sub_domain=%environment%-%webapp%-%solution%
)

set site_name=%domain%-%solution%-%webapp%-%environment%
set host_name=%sub_domain%.%domain%
set physical_path=C:\inetpub\%domain%-%solution%-%environment%\%vsproject%

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

echo # Site name:        %site_name% >> %hosts_file%
echo # Application pool: %site_name% >> %hosts_file%
echo # Physical path:    %physical_path% >> %hosts_file%
echo 127.0.0.1           %host_name% >> %hosts_file%
echo. >> %hosts_file%

exit /b