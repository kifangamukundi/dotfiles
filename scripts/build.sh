#!/bin/bash

sudo apt update

package_list="build-essential cmake libevent-dev libncurses-dev pkg-config bison byacc unzip git curl fontconfig ripgrep xclip fuse i3 picom polybar rofi"
sudo apt install -y $package_list

success=true
for package in $package_list; do
  if ! dpkg -s $package &>/dev/null; then
    echo "Failed to install $package!"
    success=false
  fi
done

if [ "$success" = true ]; then
  echo "Build-essential and development tools installed successfully!"
else
  echo "Build-essential installation may be incomplete."
  exit 1
fi

echo "Script execution complete."
