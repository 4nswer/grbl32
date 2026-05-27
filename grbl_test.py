import serial
import time

port = 'COM8'
baud = 115200

print(f"Connecting to GRBL on {port} at {baud} baud...")
s = serial.Serial(port, baud, timeout=2)
time.sleep(2)  # Wait for GRBL to boot

# Clear any startup messages
s.write(b'\r\n')
time.sleep(0.3)
startup = s.read(s.in_waiting)
print("Startup message:", startup.decode('utf-8', errors='replace').strip())

# Reset EEPROM settings to firmware defaults
print("\n--- Resetting EEPROM to defaults ($RST=$) ---")
s.write(b'$RST=$\r\n')
time.sleep(1)
r = s.read(s.in_waiting)
print("Response:", r.decode('utf-8', errors='replace').strip())

# Unlock from alarm state
print("\n--- Unlocking alarm state ($X) ---")
s.write(b'$X\r\n')
time.sleep(0.5)
r = s.read(s.in_waiting)
print("Response:", r.decode('utf-8', errors='replace').strip())

# Query status
print("\n--- Status report (?) ---")
s.write(b'?')
time.sleep(0.3)
r = s.read(s.in_waiting)
print("Response:", r.decode('utf-8', errors='replace').strip())

# Read all GRBL settings
print("\n--- GRBL Settings ($$) ---")
s.write(b'$$\r\n')
time.sleep(1)
r = s.read(s.in_waiting)
print(r.decode('utf-8', errors='replace').strip())

s.close()
print("\nDone.")
