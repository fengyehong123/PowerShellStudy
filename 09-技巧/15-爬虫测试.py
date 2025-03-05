import os
import json
import time

import asyncio
import aiohttp
import requests

import shutil
from pathlib import Path

# 请求头对象
headers = {
    "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/95.0.4638.69 Safari/537.36"
}

# 桌面文件对象
folder_path = Path.home() / "Desktop" / "img_forder"

def get_img_url(web_url):

    # 获取对应网址的响应对象
    response = requests.get(web_url, headers=headers)
    if response.status_code != 200:
        raise Exception(f"对{web_url}的访问失败...")
    
    # 获取json数据
    jsonDataList = response.json()

    # 使用列表推导式, 从json数据中解析出图片的url
    img_url_list = [webJson.get("download_url") for webJson in jsonDataList]
    return img_url_list

async def download_picture(session, img_url):

        async with session.get(img_url, ssl=False) as response:

            if response.status != 200:
                print(f"对{img_url}的访问失败...")
                return
            
            # 获取应存储图片的绝对路径
            img_name = "_".join(img_url.split("/")[-3:])
            img_path = (folder_path / f"{img_name}.jpg").resolve()
            
            # 获取响应数据
            data = await response.read()

            """
                aiofile 速度较慢，因为它底层仍然依赖 同步文件 API
                可以用 asyncio.to_thread() 在后台线程执行 Path.write_bytes()
                进行同步写入，提高性能
            """
            await asyncio.to_thread(img_path.write_bytes, data)

async def main():

    # 若文件夹存在，就直接删除
    if folder_path.exists():
        # 删除时，避免文件占用时崩溃
        shutil.rmtree(folder_path, ignore_errors=True)
    # 在桌面上新建存储图片的文件夹
    folder_path.mkdir(parents=True)

    # 从该URL的JSON响应中解析出图片的URL地址
    url = "https://picsum.photos/v2/list"
    img_url_list = get_img_url(url)

    """
        打印获取到的图片URL
        使用 * 对img_url_list进行解包
    """
    print('\033[91m获取到的图片URL如下...\033[0m')
    print(*img_url_list, sep='\n')
    print('\033[91m-----------------------------------------------\033[0m')

    async with aiohttp.ClientSession(headers=headers) as session:

        print("开始下载获取到的图片...")
        start = time.time()

        # 开启下载图片的协程任务
        task_list = [download_picture(session, img_url) for img_url in img_url_list]
        
        # 等待请求结束
        await asyncio.gather(*task_list)
        end = time.time()

        print(f"图片下载完成, 共耗时{end - start:.3f}秒")

if __name__ == '__main__':
    asyncio.run(main())