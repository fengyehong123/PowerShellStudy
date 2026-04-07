# 弹出框组件
using namespace System.Windows.Forms
Add-Type -AssemblyName System.Windows.Forms

$desktop = [Environment]::GetFolderPath("Desktop")
$filePath = Join-Path $desktop "pc_ip_address.txt"

function New-NetIPAddressInfoFile {
    param(
        [string]$filePath
    )
    Get-NetIPAddress -AddressFamily IPv4 | Where-Object { $_.IPAddress -ne "127.0.0.1" } | Select-Object InterfaceAlias, IPAddress | Out-File -FilePath $filePath -Encoding UTF8
    Write-Host "已生成文件：$filePath"
}

function Push-FileToWinScp {

    param(
        [string]$server_alias,
        [string]$upload_file,
        [string]$remote_folder
    )

    [IO.FileSystemInfo]$ItemFile = Get-Item -LiteralPath "$upload_file"
    if (-not $ItemFile.Exists) {
        Write-Host "${upload_file}文件并不存在, 请确认"
        return
    }

    # WinScp安装路径下的WinSCP.com命令行工具
    $WinScpCom = "${env:ProgramFiles(x86)}\WinSCP\WinSCP.com"
    if (-not (Test-Path $WinScpCom)) {
        [MessageBox]::Show("找不到:${WinScpCom},请确认WinScp的安装路径", "ERROR", [MessageBoxButtons]::OK, [MessageBoxIcon]::Error)
        return
    }

    # 将文件上传到Winscp中
    try {
        & "$WinScpCom" /command "open $server_alias" "put $upload_file $remote_folder" "exit"
    } catch {
        Write-Host "ip地址文件上传失败" -ForegroundColor Red
    } finally {
        # 删除上传完的IP地址文件
        $ItemFile.Delete()
    }
}

# 创建ip地址文件
New-NetIPAddressInfoFile -filePath $filePath

# 将ip地址文件上传到服务器
$remote_folder = "/data/data/com.termux/files/home/"
$server_alias = "Admin@192.168.3.22"
Push-FileToWinScp -server_alias $server_alias -upload_file $filePath -remote_folder $remote_folder