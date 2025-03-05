import sys
import subprocess
import importlib.util

# 要自动安装的模块名称
package_name_list = [
    "aiohttp",
    "asyncio",
    "requests"
]

for packageName in package_name_list:
    
    if importlib.util.find_spec(packageName) is None:

        print(f"检测到 {packageName} 未安装，正在安装...")
        subprocess.check_call([sys.executable, "-m", "pip", "install", packageName])
        print(f"{packageName} 安装完成！")

    else:
        print(f"{packageName} 已安装。")