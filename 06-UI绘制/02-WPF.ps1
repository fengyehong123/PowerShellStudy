Add-Type -AssemblyName PresentationFramework

# 定义 XAML 界面
$xaml = @"
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        Title="WPF 示例" Height="200" Width="300">
    <StackPanel>
        <TextBox x:Name="InputTextBox" Width="250" Margin="10"/>
        <Button x:Name="ConfirmButton" Content="确定" Width="100" Margin="10"/>
    </StackPanel>
</Window>
"@

# 加载 XAML 界面
$reader = New-Object System.Xml.XmlNodeReader ([xml]$xaml)
$window = [System.Windows.Markup.XamlReader]::Load($reader)

# 查找控件
$inputTextBox = $window.FindName("InputTextBox")
$confirmButton = $window.FindName("ConfirmButton")

# 添加按钮点击事件
$confirmButton.Add_Click({
    $showMsg = "您输入了: $($inputTextBox.Text)"
    [System.Windows.MessageBox]::Show($showMsg, "提示")
    $window.Close()
})

# 显示窗口
$window.ShowDialog()

Read-Host "按 Enter 键退出..."