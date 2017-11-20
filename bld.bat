:: Setup env variables
call setvars.bat
if errorlevel 1 exit 1

:: Create fresh build dir
IF EXIST c_build (
    rmdir c_build
    mkdir c_build
) ELSE (
    mkdir c_build
)
if errorlevel 1 exit 1

:: Build C library
cd c_build
cl /O2 /c ..\src\ias_lib\*.c
if errorlevel 1 exit 1
lib *.obj /out:l8ang.lib
if errorlevel 1 exit 1
rm *.obj
if errorlevel 1 exit 1
cl /O2 /c ..\src\*.c
if errorlevel 1 exit 1
lib *.obj l8ang.lib /out:..\l8_angles.lib
if errorlevel 1 exit 1
cd ..

:: Setup python package
%PYTHON% setup.py install --single-version-externally-managed ^
--record=record.txt
if errorlevel 1 exit 1

