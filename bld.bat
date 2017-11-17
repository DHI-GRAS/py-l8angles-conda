:: Setup env variables
call setvars.bat

:: Create fresh build dir
IF EXIST c_build (
    rmdir c_build
    mkdir c_build
) ELSE (
    mkdir c_build
)

:: Build C library
cd c_build
cl /O2 /c ..\src\ias_lib\*.c
lib *.obj /out:l8ang.lib
rm *.obj
cl /O2 /c ..\src\*.c
lib *.obj l8ang.lib /out:..\l8_angles.lib
cd ..

:: Setup python package
%PYTHON% setup.py install --single-version-externally-managed ^
--record=record.txt

