<#
📌.vcf = vCard 文件
    全称：Virtual Contact File
    本质：纯文本文件
    用途：存储联系人信息

📌常见于：
    手机通讯录导入 / 导出
    邮箱联系人（Outlook / Gmail）
    批量迁移通讯录

📌一个 .vcf 文件里：
    可以 只有一个联系人
    也可以 包含多个联系人

📌vCard 的几个版本
    1️⃣ vCard 2.1（最老，但最稳）
        年代：功能机 / 早期安卓
        优点：兼容性之王
        缺点：功能少、写法老
    2️⃣ vCard 3.0（最常用）
        Windows / Outlook / Android 主流
        功能和兼容性平衡最好
    3️⃣ vCard 4.0（最新、最规范）
        RFC 6350
        Web / iOS / 新安卓友好
        老国产系统支持不完整
#>

# 存储联系人的数组
$contacts = @(
    @{
        FirstName = "三"
        LastName  = "张"
        Phone     = "13800138000"
    },
    @{
        FirstName = "四"
        LastName  = "李"
        Phone     = "13900139000"
    }
)

$cards = foreach ($c in $contacts) {
    @(
        "BEGIN:VCARD"
        "VERSION:4.0"
        "N:$($c.LastName);$($c.FirstName);;;"
        "FN:$($c.LastName)$($c.FirstName)"
        "TEL;TYPE=cell:$($c.Phone)"
        "END:VCARD"
    ) -join "`n"
}

# 强制：UTF-8 无 BOM + LF
[System.IO.File]::WriteAllText(
    ".\contacts.vcf",
    ($cards -join "`n"),
    (New-Object System.Text.UTF8Encoding($false))
)
