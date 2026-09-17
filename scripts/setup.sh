#!/bin/bash
package_list="i3 xorg xinit picom feh polybar mpd mpc mpv socat alacritty ansible pipewire pipewire-pulse wireplumber pavucontrol git rsync fonts-noto-color-emoji oathtool psmisc freepats timidity inotify-tools"

sudo apt install -y $package_list

success=true
for package in $package_list; do
  if ! dpkg -s $package &>/dev/null; then
    echo "Failed: $package!"
    success=false
  fi
done

if [ "$success" = true ]; then
  echo "Success"
else
  echo "Failed"
  exit 1
fi
