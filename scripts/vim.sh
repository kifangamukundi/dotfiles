#!/bin/bash

set -e

VERSION="v9.1.1346" 

echo "🧹 Preparing to clean-install Vim ${VERSION}..."

echo "🔥 Removing all system Vim binaries..."
for vim_path in /usr/bin/vim /usr/local/bin/vim /opt/vim; do
  if [ -f "$vim_path" ]; then
    sudo rm -f "$vim_path"
    echo "    Removed: $vim_path"
  fi
done


echo "📥 Downloading Vim ${VERSION}..."
mkdir -p ~/bin
cd ~/bin
RELEASE_URL="https://github.com/vim/vim-appimage/releases/download/${VERSION}/Vim-${VERSION}.glibc2.34-x86_64.AppImage"
FILENAME="Vim-x86_64.AppImage"

if ! curl -L -o "$FILENAME" "$RELEASE_URL"; then
  echo "❌ Download failed. Check:"
  exit 1
fi

chmod +x "$FILENAME"
sudo mv "$FILENAME" /usr/local/bin/vim
sudo ln -sf /usr/local/bin/vim /usr/local/bin/vi 

echo "✅ Installation complete:"
/usr/local/bin/vim --version | head -n 3
echo "Vim installed at: $(which vim)"
