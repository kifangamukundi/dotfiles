#!/bin/bash
# uninstall.sh - Cleanly remove habit from the system

set -e

echo "Uninstalling habit..."

# --- DNS RECOVERY ---
echo "Unlocking and restoring DNS..."

# 1. Unlock resolv.conf and restore a public provider (Cloudflare)
sudo chattr -i /etc/resolv.conf 2>/dev/null || true
echo "nameserver 1.1.1.1" | sudo tee /etc/resolv.conf > /dev/null
echo "DNS restored to 1.1.1.1"

# --- SERVICE REMOVAL ---

# 2. Stop and disable the service
sudo systemctl stop habit || true
sudo systemctl disable habit || true

# 3. Remove systemd unit file
sudo rm -f /etc/systemd/system/habit.service
sudo systemctl daemon-reload

# 4. Remove binary and configurations
sudo rm -f /usr/local/bin/habit
sudo rm -rf /etc/habit /var/lib/habit

# 5. Remove the system user
if id "habit" &>/dev/null; then
    sudo userdel habit
fi

echo "habit has been completely uninstalled and system DNS restored."
