<#
    在 PowerShell 里嵌入一段 C# 代码，用 Windows 的 Core Audio API 来控制系统音量和静音。
    PowerShell 本身没有直接修改系统主音量的命令，所以需要用 C# 调用 Windows 底层接口。

    C#代码段的作用
        1. 定义音量控制接口 (IAudioEndpointVolume)
        2. 定义音频设备接口 (IMMDevice)
        3. 获取默认音频设备
        4. 提供 Audio 类给 PowerShell 调用

    最后暴露出的两个属性
        Audio.Volume
        Audio.Mute
#>
Add-Type -TypeDefinition @'
using System;
using System.Runtime.InteropServices;

[Guid("5CDF2C82-841E-4546-9722-0CF74078229A"), InterfaceType(ComInterfaceType.InterfaceIsIUnknown)]
interface IAudioEndpointVolume
{
    int f();
    int g();
    int h();
    int i();
    int SetMasterVolumeLevelScalar(float fLevel, System.Guid pguidEventContext);
    int j();
    int GetMasterVolumeLevelScalar(out float pfLevel);
    int k();
    int l();
    int m();
    int n();
    int SetMute([MarshalAs(UnmanagedType.Bool)] bool bMute, System.Guid pguidEventContext);
    int GetMute(out bool pbMute);
}

[Guid("D666063F-1587-4E43-81F1-B948E807363F"), InterfaceType(ComInterfaceType.InterfaceIsIUnknown)]
interface IMMDevice
{
    int Activate(ref System.Guid id, int clsCtx, int activationParams, out IAudioEndpointVolume aev);
}

[Guid("A95664D2-9614-4F35-A746-DE8DB63617E6"), InterfaceType(ComInterfaceType.InterfaceIsIUnknown)]
interface IMMDeviceEnumerator
{
    int f();
    int GetDefaultAudioEndpoint(int dataFlow, int role, out IMMDevice endpoint);
}

[ComImport, Guid("BCDE0395-E52F-467C-8E3D-C4579291692E")]
class MMDeviceEnumeratorComObject { }

public class Audio
{
    static IAudioEndpointVolume Vol()
    {
        var enumerator = new MMDeviceEnumeratorComObject() as IMMDeviceEnumerator;
        IMMDevice dev = null;
        Marshal.ThrowExceptionForHR(enumerator.GetDefaultAudioEndpoint(0, 1, out dev));

        IAudioEndpointVolume epv = null;
        var epvid = typeof(IAudioEndpointVolume).GUID;
        Marshal.ThrowExceptionForHR(dev.Activate(ref epvid, 23, 0, out epv));

        return epv;
    }

    public static float Volume
    {
        get {
            float v = -1;
            Marshal.ThrowExceptionForHR(Vol().GetMasterVolumeLevelScalar(out v));
            return v;
        }
        set {
            Marshal.ThrowExceptionForHR(Vol().SetMasterVolumeLevelScalar(value, System.Guid.Empty));
        }
    }

    public static bool Mute
    {
        get {
            bool mute;
            Marshal.ThrowExceptionForHR(Vol().GetMute(out mute));
            return mute;
        }
        set {
            Marshal.ThrowExceptionForHR(Vol().SetMute(value, System.Guid.Empty));
        }
    }
}
'@

function Set-AudioVolume {

    param(
        $Volume,
        [switch]$Mute
    )

    # 设置音量
    [Audio]::Volume = $Volume

    # 设置静音
    if ($Mute) {
        [Audio]::Mute = $true
    }
}

# 检查 Edge浏览器 是否在运行
$edge = Get-Process msedge -ErrorAction SilentlyContinue
if ($null -eq $edge) {
    return
}

# 关闭 Edge 浏览器
$edge.Kill()

# 加载语音合成库
Add-Type -AssemblyName System.Speech
# 创建语音对象
$syn = New-Object System.Speech.Synthesis.SpeechSynthesizer

# 设置语速和音量
$syn.Rate = -1
$syn.Volume = 100

# 调高系统音量
Set-AudioVolume -Volume 1

# 语音提醒两次
1..2 | ForEach-Object {
    $syn.Speak("请注意, 现在开始语音提醒。")
}
$syn.Speak("电脑还有一分钟就将强制关闭，请及时保存工作文件。")

# 暂停60秒钟
Start-Sleep -Seconds 60

# 倒计时提醒
$syn.Speak("现在倒计时关电脑：五，四，三，二，一。")

# 降低系统音量
Set-AudioVolume -Volume 0.2

$syn.Speak("关机")

# 强制关机
# Stop-Computer -Force