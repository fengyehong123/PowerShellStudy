Add-Type -AssemblyName System.Windows.Forms

# 创建一个简单的输入框
$form = New-Object System.Windows.Forms.Form
$form.Text = "输入框示例"
$form.Width = 300
$form.Height = 150

# 添加一个文本框
$textBox = New-Object System.Windows.Forms.TextBox
$textBox.Width = 250
$textBox.Location = New-Object System.Drawing.Point(10, 10)
$form.Controls.Add($textBox)

# 添加一个按钮
$button = New-Object System.Windows.Forms.Button
$button.Text = "确定"
$button.Location = New-Object System.Drawing.Point(10, 50)
$form.Controls.Add($button)

# 添加点击事件
$button.Add_Click({
    Write-Host "您输入了: $($textBox.Text)"
    $form.Close()
})

# 显示窗口
$form.ShowDialog() | Out-Null
