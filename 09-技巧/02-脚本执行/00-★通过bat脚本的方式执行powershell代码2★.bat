@echo off
setlocal enabledelayedexpansion

:: ���ñ���,������powershell�ű��洢����ʱĿ¼��
:: ���ű��������������,�ɷ�ֹ�ļ���ͻ
set "psScript=%temp%\temp_ps_script_%random%.ps1"

:: ��ȡ�νű��С�:: PowerShellStart��֮���powershell����, ������ӵ���ʱ�洢�õ�powershell�ű���
for /f " delims=:" %%i in ('findstr /n "^:: PowerShellStart$" "%~f0"') do (
    more +%%i "%~f0" > "%psScript%"
)

:: ��bat������ű��е���powershell
powershell.exe -NoLogo -NoProfile -ExecutionPolicy Bypass -File "%psScript%"

:: ɾ���洢�ű��õ���ʱ�ļ�
if exist "%psScript%" del "%psScript%"

:: �˳�bat������ű�
exit /b

:: PowerShellStart
Add-Type -AssemblyName Microsoft.VisualBasic

$userInput = [Microsoft.VisualBasic.Interaction]::InputBox("����������������", "�����", "Ĭ��ֵ")
Write-Output "��������ǣ�$userInput"

Read-Host "�� Enter ���˳�..."