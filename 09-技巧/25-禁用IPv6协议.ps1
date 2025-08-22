# 列出当前所有网卡的 名称 和 描述
Get-NetAdapter | Select-Object Name, InterfaceDescription
<#
    Name             InterfaceDescription
    ----             --------------------
    以太网           Realtek PCIe GBE Family Controller
    以太网 2         VMware Virtual Ethernet Adapter for VMnet1 #2
    WLAN             Intel(R) Dual Band Wireless-AC 3168
    VPN - VPN Client VPN Client Adapter - VPN
    以太网 3         VMware Virtual Ethernet Adapter for VMnet8 #2
#>

# 这行命令会在名为【以太网】的网卡上 禁用 IPv6 协议。
# 相当于在 网络适配器属性 里面，把 Internet Protocol Version 6 (TCP/IPv6) 的勾去掉。
Disable-NetAdapterBinding -Name "以太网" -ComponentID "ms_tcpip6"