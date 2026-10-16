################
# 创建内部交换机
################
# 创建之后，Windows 通常还会自动生成一个宿主机虚拟网卡【vEthernet (Hyper-V-Win10)】
# 该虚拟网卡是宿主机连接这个内部虚拟网络的接口
New-VMSwitch -Name "Hyper-V-Win10" -SwitchType Internal

# 查看 Hyper-V 虚拟交换机
Get-VMSwitch -Name "Hyper-V-Win10"

##############################
# 为新建的虚拟网卡设置固定 IP
##############################
# 192.168.10.1：这是宿主机在 NAT 网络中的 IP，也将作为虚拟机的默认网关。
# 只要和路由器的 192.168.3.x 不冲突就行
New-NetIPAddress -InterfaceAlias "vEthernet (Hyper-V-Win10)" -IPAddress 192.168.10.1 -PrefixLength 24

# 查看宿主机虚拟网卡的 IP
Get-NetIPAddress -InterfaceAlias "vEthernet (Hyper-V-Win10)" -AddressFamily IPv4

################
# NAT网络规则
################
# NAT（Network Address Translation，网络地址转换）会让内部虚拟机使用私有 IP 地址访问外部网络时，由 Windows 对网络流量进行地址转换。
# 创建
New-NetNat -Name "Win10-NAT" -InternalIPInterfaceAddressPrefix "192.168.10.0/24"
# 查看
Get-NetNat -Name "Win10-NAT"
# 删除
Remove-NetNat -Name "Win10-NAT"

# 让指定的虚拟机使用指定的虚拟内部交换机
Connect-VMNetworkAdapter -VMName "Win10" -SwitchName "Hyper-V-Win10"

########################################
# 虚拟机中的网络适配器中需要手动指定
# IP：192.168.10.5
# 子网掩码：255.255.255.0
# 默认网关：192.168.10.1
# DNS服务器：223.5.5.5（阿里云公共DNS）
#######################################

################
# 删除虚拟交换机
################
# 虚拟交换机被删除之后，虚拟网卡会一并被删除
Remove-VMSwitch -Name "Hyper-V-Win10"