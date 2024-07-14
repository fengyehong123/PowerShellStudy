function Get-Msg {
    [CmdletBinding()]
    param(
        <#
            标记该函数的参数可以来自于管道符
            如果想要通过管道符来传递数据的话,必须添加此配置项
        #>
        [Parameter(ValueFromPipeline)]
        [string]$msg
    )

    process {
        $msg
    }
}

"你好,世界" | Get-Msg