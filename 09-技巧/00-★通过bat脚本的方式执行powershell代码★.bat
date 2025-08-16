@(echo '> NUL
echo off)
:: ������������������������������������������������������������������������������������������������
:: @ �� ��ֹ�������������
:: ����Ĵ���д�˵��޹ؽ�Ҫ�Ķ������������Ϊαװ��ע�ͣ�
:: ��Ҫ�Ǳ�֤�ű�һ����˫������ʱ�����ᵯ���������ݡ�
:: ������������������������������������������������������������������������������������������������

REM ���� �ӳٱ�����չ�������� !VAR! ��ѭ���ﶯ̬��ȡֵ��
setlocal ENABLEDELAYEDEXPANSION

:: ARGV0 
::      ���浱ǰ������ű��� ����·��
:: %~f0
::      ��ȡ��ǰ�ű��ļ�������·��
set ARGV0=%~f0
: �������������в���
set ARGS=%*
: ����������
set ARGC=0

:: �������д���Ĳ����������Ǵ洢�������������ʽ
::     ARGV1=��һ������
::     ARGV2=�ڶ�������
:: ARGC ���վ��ǲ����ܸ���
for %%V in (%*) do (
    set /a ARGC=!ARGC!+1
    set ARGV!ARGC!=%%V
)

REM ���� PowerShell, ��ִ������
REM      (Get-Content "%ARGV0: = %") -join "`n"
REM           �ѵ�ǰ�ű��ļ���������, ƴ�ӳ�һ�� PowerShell ���� (�Ի��з�����)
REM      Invoke-Expression
REM           ִ�ж�ȡ���� PowerShell ����
PowerShell.exe -Command "Invoke-Expression -Command ((Get-Content \"%ARGV0: `=` `%\") -join \"`n\")"
exit /b %errorlevel%
') | Out-Null

# + ����������������������������������������������������������������Ϊbat��������벿�֡����������������������������������������������������������� +
<#
    ����ű�������
        1. ��νű�ʹ���� ��Bat + PowerShell ���Ļ�Ͻű�д��
        2. ǰ��Ρ�.bat ���֡���Ϊ�� �Ծ� (bootstrap),
           ��һ���ļ����ܵ��� �������ļ�˫������, ����������д PowerShell �ű�

    �������˼�����
       1. �ڡ�.bat���������ڲ����á�PowerShell.exe��ִ�� PowerShell �ű�
       2. ��ȡ��.bat�������ű��ڲ��� PowerShell ����Ȼ��ִ��
    
    ��������д�ĺô��ǡ���
       1. ����ֱ��˫���ű��ļ���ִ�� PowerShell ����
       2. �����ڡ�.bat�������ڲ�д PowerShell �������ҵ����
       3. ���Ա���ʹ�û�ɬ�Ѷ��ġ�.bat������
#>

# + -------------------����ΪPowerShell���벿��------------------- +
# + �������������������������������������������������������������������������������������������������������������������������� +
$argc=$ENV:ARGC
$argv=@()
for($i=0;$i -le $argc;$i++){
    $argv += (Get-ChildItem "ENV:ARGV$i").Value
}

# + -------------------PowerShell���봦������岿��--------------- + 
# + �������������������������������������������������������������������������������������������������������������������������� +

# ����һ����, �������о�̬����
class Project {

    # ��̬����
    static [PSCustomObject]GetCategoryInfo() {
        return [PSCustomObject]@{
            mpl = [string[]]@(
                "mpl_rt_net",
                "mpl_rt_api",
                "mpl_eu_net",
                "mpl_eu_api"
            );
            ang = @(
                "ang_rt_net",
                "ang_rt_api",
                "ang_eu_net"
            );
            qch = @(
                "qch_rt_net",
                "qch_rt_api"
            );
        }
    }
}

# ������ȡֵ��key
$key = "mpl"

# ����ȡmapӳ��
[PSCustomObject]$categoryInfoMap = [Project]::GetCategoryInfo()

# ��ͨ��key��ȡ��value
$categoryInfoList = $categoryInfoMap.$key
foreach ($categoryInfo in $categoryInfoList) {
    Write-Host "$categoryInfo" -ForegroundColor Green
}
Write-Host "+ -----------------------------------------" -ForegroundColor Red

# ����java��HashMap����ȥ����
foreach ($entry in $categoryInfoMap.PSObject.Properties) {

    # $entry.Name ���Ǽ�
    #                 mpl qch ang
    Write-Host "Key �� $($entry.Name)" -ForegroundColor Yellow

    # $entry.Value ��������
    foreach ($v in $entry.Value) {
        Write-Host "  Value �� $v"
    }
}
Write-Host "+ -----------------------------------------" -ForegroundColor Red

# ���� Java map.keySet() ���� ֻ����key
$categoryInfoMap.PSObject.Properties.Name | ForEach-Object {
    # ���� _ �ʹ���ǰ��������Ԫ��
    Write-Host "key��ֵ �� ${_}"
}
Write-Host "+ -----------------------------------------" -ForegroundColor Red

# ���� Java map.values() ���� ֻ����ֵ
foreach ($values in $categoryInfoMap.PSObject.Properties.Value) {
    foreach ($v in $values) {
        Write-Host $v
    }
}

# ��ͣ�ű�ִ��
Pause
