# 创建防火墙规则, 打开本地的9096端口, 允许外部访问
New-NetFirewallRule -DisplayName "PAC_NAT_9096" -Direction Inbound -Protocol TCP -LocalPort 9096 -Action Allow

# 暂时关闭制定的防火墙规则(非删除)
Disable-NetFirewallRule -DisplayName "PAC_NAT_9096"

# 让指定防火墙规则有效化
Enable-NetFirewallRule -DisplayName "PAC_NAT_9096"

# 删除指定防火墙规则
Remove-NetFirewallRule -DisplayName "PAC_NAT_9096"

# 查看规则是否存在
Get-NetFirewallRule -DisplayName "PAC_NAT_9096"