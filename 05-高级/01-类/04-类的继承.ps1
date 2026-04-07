# 来源
# https://learn.microsoft.com/zh-cn/powershell/module/microsoft.powershell.core/about/about_classes_inheritance?view=powershell-5.1

# 定义一个人类
class Human {

    [string]$Name

    Animal([string]$name) {
        $this.Name = $name
    }

    [void] talk() {
        "人类说话了！" | Out-Host
    }

    # 父类的静态方法
    static [void]eat() {
        "人类吃饭了！" | Out-Host
    }
}

# 定义一个子类,继承父类
class Student : Human {

    [string]$hobby

    # 构造函数的时候,指定继承父类,相当于super
    Student([string]$name, [string]$hobby) : base($name) {
        $this.hobby = $hobby
    }

    # ⏹构造函数2,传入哈希Table,构造
    Student([hashtable]$Properties) {
        $this.Init($Properties)
    }

    hidden [void] Init([hashtable]$Properties) {
        foreach ($Property in $Properties.Keys) {
            $this.$Property = $Properties.$Property
        }
    }

    [void]sleep() {
        "学生会睡觉" | Out-Host
    }
}

$student = [Student]@{
    name = '贾飞天'
    hobby = '吃饭,学习'
}
$student | Out-Host
<#
    hobby     Name
    -----     ----
    吃饭,学习 贾飞天
#>

# 子类调用继承自父类的方法
$student.talk()  # 人类说话了！
# 子类调用自己的方法
$student.sleep()  # 学生会睡觉

# 子类并不是继承父类的静态方法
if ($null -eq $student.eat) {
    "父类$([Human].Name)的$([Human]::eat.Name)方法并没有被子类继承!" | Out-Host
    # 父类Human的eat方法并没有被子类继承!
}