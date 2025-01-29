$data = @("选项1", "选项2", "选项3")
$selection = $data | Out-GridView -Title "请选择一个选项" -OutputMode Single
Write-Host "您选择了: $selection"
