#!/bin/bash

# ./install_luarocks.sh 5.1 3.11.1

if [ $# -lt 2 ]; then
    echo "Usage: $0 <lua_version> <luarocks_version>"
    exit 1
fi

LUA_VERSION=$1
LUAROCKS_VERSION=$2

LUA_BIN=$(which lua$LUA_VERSION)

if [ -z "$LUA_BIN" ]; then
    sudo apt-get install -y lua$LUA_VERSION lua$LUA_VERSION-dev
    LUA_BIN=$(which lua$LUA_VERSION)
    if [ -z "$LUA_BIN" ]; then
        echo "Failed to install Lua $LUA_VERSION. Exiting."
        exit 1
    fi
else
    echo "Lua $LUA_VERSION found at $LUA_BIN"
fi

LUA_INCLUDE_DIR="/usr/include/lua$LUA_VERSION"

LUAROCKS_TAR="luarocks-$LUAROCKS_VERSION.tar.gz"
LUAROCKS_DIR="luarocks-$LUAROCKS_VERSION"

if [ ! -d "$LUAROCKS_DIR" ]; then
    wget https://luarocks.org/releases/$LUAROCKS_TAR
    tar zxpf $LUAROCKS_TAR
fi

cd $LUAROCKS_DIR

./configure --with-lua-bin=$(dirname $LUA_BIN) --with-lua-include=$LUA_INCLUDE_DIR

if [ $? -eq 0 ]; then
    make build && sudo make install
else
    echo "Configuration failed. Please check Lua installation."
    exit 1
fi

cd ..
rm -rf $LUAROCKS_TAR $LUAROCKS_DIR

echo "LuaRocks $LUAROCKS_VERSION installed successfully with Lua $LUA_VERSION."
