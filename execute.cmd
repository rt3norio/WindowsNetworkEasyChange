@echo off

:: BatchGotAdmin
:-------------------------------------
REM  --> Check for permissions
>nul 2>&1 "%SYSTEMROOT%\system32\icacls.exe" "%SYSTEMROOT%\system32\config\system"

REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    echo args = "" >> "%temp%\getadmin.vbs"
    echo For Each strArg in WScript.Arguments >> "%temp%\getadmin.vbs"
    echo args = args ^& strArg ^& " "  >> "%temp%\getadmin.vbs"
    echo Next >> "%temp%\getadmin.vbs"
    echo UAC.ShellExecute "%~s0", args, "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs" %*
    exit /B

:gotAdmin
    if exist "%temp%\getadmin.vbs" ( del "%temp%\getadmin.vbs" )
    pushd "%CD%"
    CD /D "%~dp0"
:--------------------------------------


 

call config.cmd

:MENU
cls

netsh interface ipv4 show config %INTERFACENAME%

ECHO ...............................................
ECHO       CONFIGURACOES DE REDE FACILITADAS
ECHO ...............................................

ECHO 1 - SET IP FIXO %IP1% DNS DHCP 
ECHO 2 - SET IP FIXO %IP2% DNS DHCP 
ECHO 3 - SET IP FIXO %IP3% DNS DHCP 
ECHO 4 - SET IP e DNS DHCP 
ECHO 5 - SET IP DHCP e GOOGLE DNS (8.8.8.8)
ECHO 6 - SET IP FIXO %IP1% e GOOGLE DNS (8.8.8.8)
ECHO 7 - SET IP FIXO %IP2% e GOOGLE DNS (8.8.8.8)
ECHO 8 - SET IP FIXO %IP3% e GOOGLE DNS (8.8.8.8)
ECHO 9 - REFRESH
ECHO 0 - EXIT
ECHO
ECHO email: inteligenciaindustrialrj@gmail.com



SET /P M=ESCOLHA A OPCAO:
IF %M%==1 GOTO IP1
IF %M%==2 GOTO IP2
IF %M%==3 GOTO IP3
IF %M%==4 GOTO DHCP1
IF %M%==5 GOTO DHCP2
IF %M%==6 GOTO IP1G
IF %M%==7 GOTO IP2G
IF %M%==8 GOTO IP3G
IF %M%==9 GOTO MENU
IF %M%==0 GOTO EOF

:IP1
::set static IP1
echo "setting ip1"
netsh interface ipv4 set address name=%INTERFACENAME% static %IP1% %MASCARA1% %GW1%
netsh interface ipv4 set dnsservers name=%INTERFACENAME% source=dhcp
GOTO MENU

:IP2
::set static IP2
netsh interface ipv4 set address name=%INTERFACENAME% static %IP2% %MASCARA2% %GW2%
netsh interface ipv4 set dnsservers name=%INTERFACENAME% source=dhcp
GOTO MENU

:IP3
::set static IP3
netsh interface ipv4 set address name=%INTERFACENAME% static %IP3% %MASCARA3% %GW3%
netsh interface ipv4 set dnsservers name=%INTERFACENAME% source=dhcp
GOTO MENU

:DHCP1
::Set DHCP e DNSDHCP
netsh interface ipv4 set address name=%INTERFACENAME% source=dhcp
netsh interface ipv4 set dnsservers name=%INTERFACENAME% source=dhcp
GOTO MENU

:DHCP2
::Set DHCP E GOOGLE
netsh interface ipv4 set address name=%INTERFACENAME% source=dhcp
netsh interface ipv4 set dns name=%INTERFACENAME% static 8.8.8.8


GOTO MENU

:IP1G
::set static IP1
netsh interface ipv4 set address name=%INTERFACENAME% static %IP1% %MASCARA1% %GW1%
netsh interface ipv4 set dns name=%INTERFACENAME% static 8.8.8.8

GOTO MENU

:IP2G
::set static IP2
netsh interface ipv4 set address name=%INTERFACENAME% static %IP2% %MASCARA2% %GW2%
netsh interface ipv4 set dns name=%INTERFACENAME% static 8.8.8.8

GOTO MENU

:IP3G
::set static IP3
netsh interface ipv4 set address name=%INTERFACENAME% static %IP3% %MASCARA3% %GW3%
netsh interface ipv4 set dns name=%INTERFACENAME% static 8.8.8.8

GOTO MENU

:EOF
echo "Fechando!"