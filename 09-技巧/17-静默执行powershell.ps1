<#
    ⏹方式1：
        通过 Start-Process 开启一个新进程，在新进程中静默执行ps脚本
    注意：
        直接右键执行 【17-静默执行powershell.ps1】的话，还是会有一闪而过的情况
        这里的静默指定指的是
            1. 被其他命令调用
                或者
            2. 在命令行通过【.\17-静默执行powershell.ps1】执行的时候会静默
#>
Start-Process powershell.exe '-NoProfile -ExecutionPolicy RemoteSigned -File 07-生成csv文件-Ver1.ps1' -WindowStyle Hidden

<#
    ⏹方式2：
        通过vbs的方式调用PowerShell代码时，指定窗口隐藏
        详情可参考 19-RunHidden.vbs 的用法
#>