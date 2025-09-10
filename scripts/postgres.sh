#!/bin/bash

sudo rm -f /etc/apt/sources.list.d/pgdg.list /etc/apt/sources.list.d/pgdg.sources
sudo rm -f /usr/share/keyrings/postgresql.gpg /usr/share/postgresql-common/pgdg/apt.postgresql.org.gpg 2>/dev/null

sudo apt update
sudo apt install -y curl gnupg

sudo mkdir -p /usr/share/keyrings/

sudo curl -fsS https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo gpg --dearmor -o /usr/share/keyrings/postgresql-apt.gpg

sudo sh -c 'echo "deb [signed-by=/usr/share/keyrings/postgresql-apt.gpg] http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'

sudo apt update
sudo apt install -y postgresql postgresql-contrib

if command -v psql &> /dev/null; then
    echo "✅ PostgreSQL installed successfully!"
    echo "Version: $(psql --version)"
else
    echo "❌ PostgreSQL installation failed!"
    exit 1
fi
