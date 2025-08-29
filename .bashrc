# Ensure this file is only sourced in interactive shells
case $- in
    *i*) ;;
      *) return;;
esac

# Use nvim as default editor 
export EDITOR=nvim

# Don't put duplicate lines or lines starting with space in the history
HISTCONTROL=ignoreboth

# Append to the history file, don't overwrite it
shopt -s histappend

# Set history size
HISTSIZE=1000000
HISTFILESIZE=2000000

# Save history after every command
PROMPT_COMMAND='history -a; history -n'

# Avoid duplicate entries in history
HISTCONTROL=ignoredups:ignorespace:erasedups

# Add timestamps to each command in history
HISTTIMEFORMAT='%F %T '

# Alias to clean and reload history (optional)
alias history-clean="history -c && history -r && history -w"

# Export all history settings
export HISTSIZE HISTFILESIZE HISTCONTROL PROMPT_COMMAND HISTTIMEFORMAT

# Check the window size after each command and update LINES and COLUMNS
shopt -s checkwinsize

# Set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# Set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# Force color prompt if desired
if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        color_prompt=yes
    else
        color_prompt=
    fi
fi

# Define the prompt
if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm, set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# Enable color support for ls and add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
fi

# Source additional aliases from ~/.bash_aliases if it exists
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# Enable programmable completion features
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Add Go to PATH
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:$(go env GOPATH)/bin

# Add Neovim to PATH
export PATH="$PATH:/opt/nvim-linux64/bin"

# Alias Neovim to vim 
alias vim="nvim"

# Add /usr/local/bin to PATH
export PATH=/usr/local/bin:$PATH

# Cargo and rust environment setup
. "$HOME/.cargo/env"

# Initialize Starship prompt
eval "$(starship init bash)"
export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"

# Load NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"


# Set up fzf key bindings and fuzzy completion
eval "$(fzf --bash)"

# Remap escape to the Caps Lock key
setxkbmap -option caps:swapescape
xset r rate 300 50

# Bind Ctrl+f to tmux session
bind -x '"\C-f": ~/.local/bin/fsession'

alias fkill='~/.local/bin/fkill'
alias fcontainer='~/.local/bin/fcontainer'
alias fimage='~/.local/bin/fimage'
alias fvolume='~/.local/bin/fvolume'
alias fnetwork='~/.local/bin/fnetwork'
alias ffile='~/.local/bin/ffile'
alias fmusic='~/.local/bin/fmusic'
alias fvideo='~/.local/bin/fvideo'

# Start ssh-agent if not running
if ! pgrep -u "$USER" ssh-agent >/dev/null; then
  eval "$(ssh-agent -s)" >/dev/null
fi

# Add GitHub key if not loaded
ssh-add -l >/dev/null 2>&1 || ssh-add ~/.ssh/id_ed25519_github >/dev/null 2>&1
