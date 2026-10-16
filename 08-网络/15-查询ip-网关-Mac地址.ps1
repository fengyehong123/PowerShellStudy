# 查询 ipv4地址 ipv4网关 ipv6地址 ipv6网关 网卡的mac地址
Get-NetIPConfiguration | `
    Where-Object { $_.IPv4DefaultGateway -ne $null -or $_.IPv6DefaultGateway -ne $null } | `
    Select-Object InterfaceAlias,
        @{Name='IPv4';Expression={$_.IPv4Address.IPAddress -join ', '}},
        @{Name='IPv4网关';Expression={$_.IPv4DefaultGateway.NextHop -join ', '}},
        @{Name='IPv6';Expression={$_.IPv6Address.IPAddress -join ', '}},
        @{Name='IPv6网关';Expression={$_.IPv6DefaultGateway.NextHop -join ', '}},
        @{Name='MAC地址';Expression={$_.NetAdapter.MacAddress}}