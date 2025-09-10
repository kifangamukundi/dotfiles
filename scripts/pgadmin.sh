#!/bin/bash

PGADMIN_TYPE="${1:-web}"

if [[ "$PGADMIN_TYPE" != "web" && "$PGADMIN_TYPE" != "desktop" ]]; then
    echo "❌ Invalid option: $PGADMIN_TYPE"
    echo "Usage: $0 [web|desktop]"
    exit 1
fi

sudo rm -f /etc/apt/sources.list.d/pgadmin4.list
sudo rm -f /usr/share/keyrings/pgadmin.gpg 2>/dev/null

sudo apt update
sudo apt install -y curl gnupg

sudo mkdir -p /usr/share/keyrings/

echo "Adding pgAdmin4 repository..."
sudo curl -fsS https://www.pgadmin.org/static/packages_pgadmin_org.pub | sudo gpg --dearmor -o /usr/share/keyrings/pgadmin-apt.gpg

sudo sh -c "echo 'deb [signed-by=/usr/share/keyrings/pgadmin-apt.gpg] https://ftp.postgresql.org/pub/pgadmin/pgadmin4/apt/$(lsb_release -cs) pgadmin4 main' > /etc/apt/sources.list.d/pgadmin4.list"

sudo apt update

if [[ "$PGADMIN_TYPE" == "web" ]]; then
    sudo apt install -y pgadmin4-web
    echo "✅ pgAdmin4 Web installed successfully!"
else
    sudo apt install -y pgadmin4-desktop
    echo "✅ pgAdmin4 Desktop installed successfully!"
fi
