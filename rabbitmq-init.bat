SET HOMEDRIVE=C:
rem call rabbitmq-service stop
call rabbitmq-service start
call rabbitmq-plugins enable rabbitmq_management
call rabbitmqctl.bat status
call rabbitmq-server.bat start -detached
