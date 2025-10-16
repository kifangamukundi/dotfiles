#!/bin/bash
set -e

GO_VERSION="1.25.0"
ARCH=$(uname -m)

case "$ARCH" in
    x86_64) ARCH="amd64" ;;
    arm64 | aarch64) ARCH="arm64" ;;
    *) echo "Unsupported architecture: $ARCH"; exit 1 ;;
esac

GO_FILENAME="go${GO_VERSION}.linux-${ARCH}.tar.gz"
GO_DOWNLOAD_URL="https://go.dev/dl/${GO_FILENAME}"

echo "Downloading Go ${GO_VERSION} for ${ARCH}..."
curl -L -o "${GO_FILENAME}" "${GO_DOWNLOAD_URL}"

sudo rm -rf /usr/local/go
sudo tar -C /usr/local -xzf "${GO_FILENAME}"
rm "${GO_FILENAME}"

echo "✅ Go ${GO_VERSION} installation complete!"
go version
