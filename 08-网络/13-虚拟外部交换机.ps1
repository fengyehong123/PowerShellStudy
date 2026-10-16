# 查看所有虚拟机的名称
Get-VM

###################### 
# 创建外部交换机
######################
# 创建外部交换机的时候没有 -SwitchType 配置项
# 通过 -NetAdapterName 指定了物理网卡，就相当于指定创建外部交换机
New-VMSwitch -Name "ExternalSwitch" -NetAdapterName "WLAN" -AllowManagementOS $true

# 查看所有的虚拟交换器的名称
Get-VMSwitch | Format-Table Name, SwitchType, NetAdapterInterfaceDescription

# 让指定的虚拟机使用指定的虚拟交换机
Connect-VMNetworkAdapter -VMName "Win10" -SwitchName "ExternalSwitch"

########################################
# 虚拟机中的IP 和 DNS服务器设置为自动获取
# 设置完成之后，才能连接网络
# 创建外部交换机之后，会自动创建一个网桥
# 外部交换机被删除之后，网桥也会被删除
#######################################

# 删除外部交换机
Remove-VMSwitch -Name "ExternalSwitch"