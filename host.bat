echo off

if not exist .vs\config\applicationhost.config (
    echo ".vs\config\applicationhost.config" not found
    goto :EOF
)

"C:\Program Files\IIS Express\iisexpress" /config:.vs\config\applicationhost.config /apppool:Clr4IntegratedAppPool