using namespace System.IO
using namespace System.Text

# 定义一个自动释放资源的Use函数
function Use {
    param (
        [Parameter(Mandatory)]
        [IDisposable]$Resource,

        [Parameter(Mandatory)]
        [scriptblock]$Script,

        [Parameter()]
        [object[]]$OtherArgs
    )

    try {
        # 执行代码块, 并向代码块中传入参数
        & $Script $Resource @OtherArgs
    } finally {
        if ($Resource) {
            $Resource.Dispose()
        }
    }
}

$fileName = "测试文件.txt"
$fileContent = "你好, PowerShell👋"

Use ([FileStream]::new("$fileName", [FileMode]::Create)) `
-Script {
    param(
        $stream,
        $content
    )
    $bytes = [Encoding]::UTF8.GetBytes("$content")
    $stream.Write($bytes, 0, $bytes.Length)
} `
-OtherArgs "$fileContent"