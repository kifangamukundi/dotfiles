#!/bin/bash
# Usage: ./scripts/extras.sh [all|redis|spotify|ffmpeg|yt-dlp]

EXTRA_TYPE="${1:-all}"

install_redis() {
    sudo apt update
    sudo apt install -y redis-tools redis-server
    
    # Test Redis installation
    if command -v redis-cli &> /dev/null; then
        echo "Version: $(redis-server --version 2>/dev/null || echo "Redis installed")"
        if systemctl is-active --quiet redis; then
            echo "✅ Redis service is running"
        else
            echo "⚠️ Redis service is not running. Start with: sudo systemctl start redis"
        fi
    else
        echo "❌ Redis installation failed!"
    fi
}

install_ffmpeg() {
    sudo apt update
    sudo apt install -y ffmpeg
    
    if command -v ffmpeg &> /dev/null; then
        echo "Version: $(ffmpeg -version | head -n 1)"
    else
        echo "❌ FFmpeg installation failed!"
    fi
}

install_yt_dlp() {
    sudo curl -L https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp -o /usr/local/bin/yt-dlp
    sudo chmod a+rx /usr/local/bin/yt-dlp
    if command -v yt-dlp &> /dev/null; then
        echo "Version: $(yt-dlp --version)"
        sudo yt-dlp -U
    else
        echo "❌ yt-dlp installation failed!"
    fi
}

install_spotify_dl() {
    if ! command -v pip3 &> /dev/null; then
        sudo apt update
        sudo apt install -y python3-pip
    fi
    if ! dpkg -s python3.11-venv &>/dev/null && ! dpkg -s python3-venv &>/dev/null; then
        sudo apt install -y python3-venv
    fi
    
    # Create virtual environment
    VENV_DIR="$HOME/virtualenvironment"
    if [ ! -d "$VENV_DIR" ]; then
        python3 -m venv "$VENV_DIR"
    fi
    source "$VENV_DIR/bin/activate"
    pip install spotdl
    deactivate
    echo "✅ Spotify download tools setup complete!"
}

valid_options=("all" "redis" "spotify" "ffmpeg" "yt-dlp")
if [[ ! " ${valid_options[@]} " =~ " ${EXTRA_TYPE} " ]]; then
    echo "❌ Invalid option: $EXTRA_TYPE"
    echo "Usage: $0 [all|redis|spotify|ffmpeg|yt-dlp]"
    exit 1
fi

case $EXTRA_TYPE in
    "redis")
        install_redis
        ;;
    "spotify")
        install_spotify_dl
        ;;
    "ffmpeg")
        install_ffmpeg
        ;;
    "yt-dlp")
        install_yt_dlp
        ;;
    "all")
        install_redis
        install_ffmpeg
        install_yt_dlp
        install_spotify_dl
        echo "✅ All extras installed successfully!"
        ;;
esac

echo "🎉 Extras installation complete!"
