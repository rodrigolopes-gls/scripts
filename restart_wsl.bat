@echo off
:: Check for admin rights
net session >nul 2>&1
if %errorLevel% == 0 (
	goto runCommands
) else (
	goto elevate
)

:elevate
echo. > "%temp%\getadmin.vbs"
echo Set UAC = CreateObject^("Shell.Application"^) >> "%temp%\getadmin.vbs"
echo UAC.ShellExecute "%~s0", "", "", "runas", 1 >> "%temp%\getadmin.vbs"
"%temp%\getadmin.vbs"
exit

:runCommands
gpupdate /force
sc stop vmcompute
sc start vmcompute
timeout /t 2
wsl
