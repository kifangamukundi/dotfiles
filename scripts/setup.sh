#!/bin/bash

package_list="i3 xorg xinit picom feh polybar mpd mpc mpv socat alacritty ansible pipewire pipewire-pulse wireplumber pavucontrol git"

sudo apt install -y $package_list

success=true
for package in $package_list; do
  if ! dpkg -s $package &>/dev/null; then
    echo "❌ Failed to install $package!"
    success=false
  fi
done

if [ "$success" = true ]; then
  echo "✅ All window manager packages installed successfully!"
else
  echo "⚠️ Package installation may be incomplete. Please check the error messages above."
  exit 1
fi

echo "Script execution complete."
