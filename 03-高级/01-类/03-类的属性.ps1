# 来源
# https://learn.microsoft.com/zh-cn/powershell/module/microsoft.powershell.core/about/about_classes_properties?view=powershell-5.1

enum Category {
    国产 = 0
    进口 = 1
}

class Card {

    # 普通属性
    [string]$Id

    [int]$Cost
    # 为属性值指定范围
    [ValidateRange(100, 200)][int]$Price = 100
    
    # 自定义属性
    [Category]$Category
    
    # 隐藏属性
    hidden [string]$Guid = (New-Guid).Guid
    # 静态属性
    static [string]$Default = '测试'

    # 自定义的动态属性计算属性
    static [hashtable[]]$MemberDefinitions = @(
        # 由于是数组,因此可以同时计算若干个属性
        @{
            MemberName = 'Profit'
            MemberType = 'ScriptProperty'
            Value = {

                if ($this.Cost -eq 0) {
                    "成本居然是0元" | Out-Host
                    return $this.Price
                }

                return $this.Price - $this.Cost
            }
        }
        , @{
            MemberName = 'ShowGuid1'
            MemberType = 'ScriptProperty'
            Value = {
                return $this.Guid
            }
        }
    )

    # 每一个类初始化的时候,调用一次该静态方法完成动态属性的添加
    static Card() {

        # 获取类的名称
        $ClassTypeName = [Card].Name

        # 获取所有的
        foreach ($Custom_Field_Definition in [Card]::MemberDefinitions) {
            Update-TypeData -TypeName $ClassTypeName @Custom_Field_Definition
        }

        # 获取一个1到10的随机数
        $random_num = Get-Random -Minimum 1 -Maximum 10
        "获取到的随机数是: $random_num" | Out-Host

        # 只有随机数是偶数的情况下,才会添加 ShowGuid2 这个属性
        if ($random_num % 2 -ne 0) {
            return
        }

        $Custom_hashTable = @{
            MemberName = 'ShowGuid2'
            MemberType = 'ScriptProperty'
            Value = {
                return (New-Guid).Guid
            }
        }

        <#
            @ 用来解构哈希表
        #>
        Update-TypeData -TypeName $ClassTypeName @Custom_hashTable
    }
}
<#
    获取到的随机数是: 8
    成本居然是0元
#>

[Card]@{
    Id = '110120'
    Price = 150
    Category = [Category]::国产
} | Out-Host
<#
    Id        : 110120
    Cost      : 0
    Price     : 150
    Category  : 国产
    Profit    : 150
    ShowGuid1 : db48d8fa-b640-4ee8-9b12-c4a926f6f470
    ShowGuid2 : d541d658-0dd5-4e75-910f-084bcba4a035
#>
Write-Host '↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳' -ForegroundColor Red

[Card]@{
    Id = '999888'
    Price = 180
    Cost = 50
    Category = [Category]::进口
} | Out-Host
<#
    Id        : 999888
    Cost      : 50
    Price     : 180
    Category  : 进口
    Profit    : 130
    ShowGuid1 : ef58d452-b05b-4a77-b31e-e79e81c31bd8
    ShowGuid2 : 8020c2ba-413b-4d5d-90ed-1b8154f2d0c0
#>
Write-Host '↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳↳' -ForegroundColor Red

# 获取静态属性
[Card]::Default | Out-Host  # 测试
# 获取类的名称
[Card].Name  # Card

Pause