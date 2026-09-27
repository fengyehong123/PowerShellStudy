Add-Type @"
public class MsgBoxType {
    public const int OK = 0;
    public const int OKCancel = 1;
    public const int AbortRetryIgnore = 2;
    public const int YesNoCancel = 3;
    public const int YesNo = 4;
    public const int RetryCancel = 5;

    public const int IconStop = 16;
    public const int IconQuestion = 32;
    public const int IconWarning = 48;
    public const int IconInformation = 64;
}
"@

# 创建WScript对象
$wsobj = New-Object -ComObject WScript.Shell

# 弹出消息框, 3秒之后自动消失
$wsobj.Popup(
    "WScript.Shell执行完毕!",
    3,
    "提示",
    [MsgBoxType]::OK
) | Out-Null

# 询问是否删除文件
$result = $wsobj.Popup(
    "是否删除文件？",
    0,
    "警告",
    [MsgBoxType]::YesNo + [MsgBoxType]::IconWarning
)

if ($result -eq 6) {
    Write-Host "用户选择了确定"
} elseif ($result -eq 6) {
    Write-Host "用户选择了取消"
}

