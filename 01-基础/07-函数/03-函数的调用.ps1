# 定义一个函数
function Get-Msg {

    [CmdletBinding()]
    param(
        # 用来标记该函数可以接受来自管道符的参数
        [Parameter(ValueFromPipeline)]
        [string]$msg
    )

    process {
        $msg
    }
}

# 定义一个变量
$my_msg = "Hello world!"

# 方式1: 调用
Print-Msg -msg $my_msg  # Hello world!

# 方式2: 调用
Print-Msg($my_msg)  # Hello world!

# 方式3: 调用
$my_msg | Get-Msg