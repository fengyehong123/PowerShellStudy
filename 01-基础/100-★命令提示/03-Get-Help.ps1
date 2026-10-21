# 计算机中可能没有安装命令模块的帮助内容, 因此在使用之前需要先安装
# 由于多数模块并没有中文的帮助文件, 因此需要指定英文
Update-Help -UICulture en-US

# 查看指定的命令如何使用
Get-Help Get-Item -Examples
Get-Help Get-Item -Full
Get-Help Get-Item -Online