#!/bin/bash

# --- Security Warning ---
echo "WARNING: This script enables root SSH login with an extremely weak password for temporary recovery purposes."
echo "         It is CRITICAL to disable root SSH login and change the password after recovery."
echo "         Press Ctrl+C to abort if you do not understand or agree with these security implications."
sleep 5 # Give user time to read the warning

# 1. Update package lists
echo "--- Running apt-get update ---"
apt-get update

# 2. Install OpenSSH server
echo "--- Installing openssh-server ---"
apt-get install ssh -y

# 3. Set root password
echo "--- Setting root password to 'password' ---"
echo "root:password" | chpasswd

# 4. Allow root login in sshd_config
echo "--- Allowing root login in /etc/ssh/sshd_config ---"
# Use sed to uncomment or set PermitRootLogin yes
sed -i 's/^#\?PermitRootLogin.*/PermitRootLogin yes/g' /etc/ssh/sshd_config

# 5. Restart SSH service
echo "--- Restarting SSH service ---"
systemctl restart ssh

echo "--- Script finished ---"
echo "You should now be able to SSH as root using the password 'password'."
echo "REMEMBER TO SECURE YOUR SYSTEM IMMEDIATELY AFTER RECOVERY!"
