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
set site_name=%domain%-%env%%app%
set site_path=C:\inetpub\%domain%\%env%%app%
set site_bindings=%env%%host_name%.%domain%

echo %app_cmd% delete site %site_name% >> %iis_script%
echo %app_cmd% delete apppool %site_name% >> %iis_script%

rem echo %app_cmd% add site /name:%site_name% /site.name:%site_name% /bindings:http://*:80 /physicalPath:%site_path% >> %iis_script%
rem echo %app_cmd% add site /name:%site_name% /site.name:%site_name% /bindings.[protocol='http://*.80',hostName='%site_name%'] /physicalPath:%site_path% >> %iis_script%

echo %app_cmd% add apppool /name:"%site_name%" /managedRuntimeVersion:"" -processModel.identityType:LocalSystem >> %iis_script%
echo %app_cmd% add site /name:"%site_name%" /site.name:"%site_name%" /bindings:"http://%site_bindings%:80" /physicalPath:"%site_path%" >> %iis_script%
echo %app_cmd% set app "%site_name%/" /applicationPool:"%site_name%" >> %iis_script%
echo %app_cmd% start apppool /apppool.name:"%site_name%" >> %iis_script%

exit /b

:create_hosts_section

echo # Site name:        %domain%-%env%%app% >> %hosts_file%
echo # Physical path:    %site_path% >> %hosts_file%
echo 127.0.0.1           %site_bindings% >> %hosts_file%
echo. >> %hosts_file%

exit /b