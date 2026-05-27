import os, subprocess, sys, glob

GCC_BIN = r"C:\Users\andrewb\AppData\Local\stm32cube\bundles\gnu-tools-for-stm32\14.3.1+st.2\bin"
PROGRAMMER = r"C:\Users\andrewb\AppData\Local\stm32cube\bundles\programmer\2.22.0+st.1\bin\STM32_Programmer_CLI.exe"

make_exe = r"C:\ProgramData\chocolatey\lib\make\tools\install\bin\make.exe"
if not os.path.exists(make_exe):
    print(f"ERROR: make.exe not found at {make_exe}")
    sys.exit(1)

print(f"Found make: {make_exe}")
print(f"Using GCC: {GCC_BIN}")

# Run make with GCC_PATH
env = os.environ.copy()
env["PATH"] = GCC_BIN + ";" + env.get("PATH", "")

cmd = [make_exe, "-C", r"C:\Github\grbl32", f"GCC_PATH={GCC_BIN}"]
print(f"\nRunning: {' '.join(cmd)}\n{'='*60}")
result = subprocess.run(cmd, env=env)
if result.returncode != 0:
    print(f"\nBuild FAILED (exit code {result.returncode})")
    sys.exit(1)

print("\n" + "="*60)
print("Build SUCCESS! Flashing...")
hex_file = r"C:\Github\grbl32\build\GRBL32_F103C8.hex"
flash_cmd = [PROGRAMMER, "-c", "port=SWD", "freq=4000", "reset=HWrst",
             "-d", hex_file, "-v", "-rst"]
result = subprocess.run(flash_cmd)
if result.returncode == 0:
    print("\n[OK] Flash complete!")
else:
    print(f"\n[ERROR] Flash failed (exit code {result.returncode})")
