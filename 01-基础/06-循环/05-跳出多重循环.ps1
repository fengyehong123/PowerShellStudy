# 设置一个标志位用来跳出循环
:outloop for ($i = 0; $i -lt 3; $i++) {

	for ($k = 0; $k -lt 3; $k++) {

		Write-Host "$i - $k"
        <#
            0 - 0
            0 - 1
            0 - 2
            1 - 0
            1 - 1
        #>
				
		if ($i -eq 1 -and $k -eq 1) {
            # 跳出二重循环
			break outloop
		}
	}
}