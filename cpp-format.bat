@echo off 

set FMT=LLVM
call :formatcpp

goto :eof

:formatcpp
for /r %%i in (*.cpp) do call clang-format -i -style=%FMT% %%i
for /r %%i in (*.hpp) do call clang-format -i -style=%FMT% %%i
goto :eof