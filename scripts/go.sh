#!/bin/bash

set -e

LATEST_VERSION=$(curl -s https://go.dev/VERSION?m=text | head -n1)
if [ -z "$LATEST_VERSION" ]; then
    echo "Error fetching latest Go version. Exiting."
    exit 1
fi
LATEST_VERSION=${LATEST_VERSION#go}

ARCH=$(uname -m)
case "$ARCH" in
    x86_64) ARCH="amd64" ;;
    arm64 | aarch64) ARCH="arm64" ;;
    *) echo "Unsupported architecture: $ARCH"; exit 1 ;;
esac

GO_FILENAME="go${LATEST_VERSION}.linux-${ARCH}.tar.gz"
GO_DOWNLOAD_URL="https://go.dev/dl/${GO_FILENAME}"

curl -L -o "${GO_FILENAME}" "${GO_DOWNLOAD_URL}"
if [ $? -ne 0 ]; then
    echo "Error downloading Go. Exiting."
    exit 1
fi

sudo rm -rf /usr/local/go

sudo tar -C /usr/local -xzf "${GO_FILENAME}"

rm "${GO_FILENAME}"

echo "Go installation complete!"
