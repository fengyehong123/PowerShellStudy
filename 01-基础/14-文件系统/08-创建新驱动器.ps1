# 判断名称为 IBCFile 的驱动器是否存在
$drive1 = Get-PSDrive -Name IBCFile -ErrorAction SilentlyContinue
if ($drive1) {
    # 若存在,则删除,删除的时候不需要添加 :
    Remove-PSDrive IBCFile
}

<#
    ⏹创建一个名为 IBCFile 的驱动器
    PowerShell创建的驱动器,除了创建网络驱动器之外,
    还可以 使用驱动器作为文件系统中的重要目录
#>
New-PSDrive -Name IBCFile -PSProvider FileSystem -Root "$($HOME)\Desktop\Mysql教育"

<#
    ⏹可以通过 cd 或者 Get-ChildItem 来移动目录,或者获取目录中的内容
    使用驱动器的时候,需要驱动器名称 + :
#>
Get-ChildItem IBCFile:

