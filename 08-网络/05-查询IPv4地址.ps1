# 获取IPv4网络地址
Get-NetIPAddress -AddressFamily IPv4 | Select-Object IPAddress,InterfaceAlias,InterfaceIndex