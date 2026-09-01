# 获取当前网络适配器的信息
Get-NetAdapter

# 获取Mac地址
Get-NetAdapter | Select-Object Name, MacAddress

Pause