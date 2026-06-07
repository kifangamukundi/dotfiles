#!/bin/bash
# install.sh - Installation script for habit

set -e

echo "Installing habit..."

# 1. Build the binary
go build -o habit cmd/habit/main.go
sudo cp habit /usr/local/bin/habit

# 2. Grant capabilities to bind to port 53
sudo setcap cap_net_bind_service=+ep /usr/local/bin/habit

# 3. Create a system user if it doesn't exist
if ! id "habit" &>/dev/null; then
    sudo useradd -r -s /bin/false habit
fi

# 4. Create configuration and data directories
sudo mkdir -p /etc/habit /var/lib/habit
sudo chown habit:habit /var/lib/habit

# 5. Install default config if not exists
if [ ! -f /etc/habit/config.yaml ]; then
    sudo cp configs/config.yaml /etc/habit/config.yaml
fi

# 6. Install and enable systemd service
sudo cp scripts/habit.service /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl enable habit
sudo systemctl start habit

# --- SYSTEM DNS INTEGRATION ---
echo "Enforcing system-wide DNS..."

# 7. Point resolv.conf to localhost and LOCK it
# Using immutable bit to prevent DHCP client from overwriting it.
sudo chattr -i /etc/resolv.conf 2>/dev/null || true
echo "nameserver 127.0.0.1" | sudo tee /etc/resolv.conf > /dev/null
sudo chattr +i /etc/resolv.conf

echo "DNS locked to 127.0.0.1 (immutable)"
echo "habit installed and enforced successfully."
echo "You can check status with: systemctl status habit"
