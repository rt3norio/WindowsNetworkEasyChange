@echo off
::
::Para checar o nome da interface
::EXECUTE O COMANDO ABAIXO!
::netsh interface ipv4 show config
set INTERFACENAME="Ethernet"

::CONFIG DOS IPs
set IP1="192.168.0.254"
set MASCARA1="255.255.255.0"
set GW1="192.168.0.1"


set IP2="192.168.1.254"
set MASCARA2="255.255.255.0"
set GW2="192.168.1.1"


set IP3="10.0.0.254"
set MASCARA3="255.255.255.0"
set GW3="10.0.0.1"