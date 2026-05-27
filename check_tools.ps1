Write-Host "=== Checking for required tools ===" -ForegroundColor Cyan

$tools = @("STM32_Programmer_CLI", "arm-none-eabi-gcc", "make", "st-flash", "st-info")
foreach ($tool in $tools) {
    $found = Get-Command $tool -ErrorAction SilentlyContinue
    if ($found) {
        Write-Host "[FOUND] $tool -> $($found.Source)" -ForegroundColor Green
    } else {
        Write-Host "[NOT FOUND] $tool" -ForegroundColor Red
    }
}

Write-Host ""
Write-Host "=== Searching common install locations ===" -ForegroundColor Cyan

$cubePaths = @(
    "C:\Program Files\STMicroelectronics\STM32Cube\STM32CubeProgrammer\bin\STM32_Programmer_CLI.exe",
    "C:\Program Files (x86)\STMicroelectronics\STM32Cube\STM32CubeProgrammer\bin\STM32_Programmer_CLI.exe",
    "$env:LOCALAPPDATA\Programs\STMicroelectronics\STM32Cube\STM32CubeProgrammer\bin\STM32_Programmer_CLI.exe"
)
foreach ($p in $cubePaths) {
    if (Test-Path $p) {
        Write-Host "[FOUND] STM32CubeProgrammer at: $p" -ForegroundColor Green
    }
}

$gccPaths = @(
    "C:\Program Files (x86)\GNU Arm Embedded Toolchain",
    "C:\Program Files\GNU Arm Embedded Toolchain",
    "C:\Program Files (x86)\GNU Tools ARM Embedded"
)
foreach ($p in $gccPaths) {
    if (Test-Path $p) {
        Write-Host "[FOUND] ARM GCC directory: $p" -ForegroundColor Green
        Get-ChildItem $p | ForEach-Object { Write-Host "  -> $($_.FullName)" }
    }
}

Write-Host ""
Write-Host "=== STM32CubeProgrammer install search ===" -ForegroundColor Cyan
$cubeSearch = Get-ChildItem "C:\Program Files*\STMicroelectronics" -Recurse -Filter "STM32_Programmer_CLI.exe" -ErrorAction SilentlyContinue
if ($cubeSearch) {
    foreach ($f in $cubeSearch) { Write-Host "[FOUND] $($f.FullName)" -ForegroundColor Green }
} else {
    Write-Host "STM32_Programmer_CLI.exe not found under C:\Program Files*\STMicroelectronics" -ForegroundColor Yellow
}
