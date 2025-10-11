# ZSH FRAMEWORK CONFIGURATION 
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"

plugins=(
    zsh-syntax-highlighting
    # zsh-autosuggestions
)

# CUSTOM SYNTAX HIGHLIGHTING (ROSE PINE MOON HARMONY)
typeset -A ZSH_HIGHLIGHT_STYLES

# 1. COMMANDS — Primary action: Pine (Teal/Blue)
ZSH_HIGHLIGHT_STYLES[command]='fg=#31748f,bold'

# 2. ALIASES / FUNCTIONS — Secondary structures: Foam (Light Cyan)
ZSH_HIGHLIGHT_STYLES[alias]='fg=#9ccfd8'
ZSH_HIGHLIGHT_STYLES[function]='fg=#9ccfd8'

# 3. UNKNOWN / ERROR — Rose on muted background for visibility
ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=#eb6f92,bold'

# 4. OPTIONS / FLAGS — Gold, for emphasis
ZSH_HIGHLIGHT_STYLES[precommand]='fg=#f6c177'

# 5. PATHS / DIRECTORIES — Muted gray to blend into the background
ZSH_HIGHLIGHT_STYLES[path]='fg=#6e6a86'
ZSH_HIGHLIGHT_STYLES[path_prefix]='fg=#6e6a86'

# 6. VARIABLES / PARAMETERS — Iris or Text, depending on your contrast preference
ZSH_HIGHLIGHT_STYLES[dollar-variable]='fg=#c4a7e7'
ZSH_HIGHLIGHT_STYLES[param]='fg=#c4a7e7'

# 7. COMMENTS / REDIRECTION — Muted, non-distracting
ZSH_HIGHLIGHT_STYLES[comment]='fg=#6e6a86,italic'
ZSH_HIGHLIGHT_STYLES[redirection]='fg=#eb6f92'

# 8. STRINGS / QUOTES — Foam greenish-cyan, bright but soft
ZSH_HIGHLIGHT_STYLES[quotation]='fg=#9ccfd8'

# 9. NUMBERS / CONSTANTS — Gold for consistency
ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter]='fg=#f6c177'

# 10. GLOBS / WILDCARDS — Pine for subtle emphasis
ZSH_HIGHLIGHT_STYLES[globbing]='fg=#31748f'

# VI MODE REGION 
ZSH_HIGHLIGHT_STYLES[region]='bg=#393552'

source $ZSH/oh-my-zsh.sh

# User Configuration starts below the OMZ sourcing

# HISTORY SETTINGS
HISTSIZE=1000000
SAVEHIST=2000000
HIST_STAMP='%F %T'

# Zsh History Options
setopt appendhistory
setopt sharehistory
setopt hist_ignore_dups
setopt hist_ignore_space
setopt extendedhistory
setopt checkjobs 

# SSH AGENT MANAGEMENT 
if ! pgrep -u "$USER" ssh-agent >/dev/null; then
    eval "$(ssh-agent -s | grep -v 'echo')" > "$HOME/.ssh-agent-env"
fi

if [ -f "$HOME/.ssh-agent-env" ]; then
    . "$HOME/.ssh-agent-env"
fi

# Add keys if not loaded
if ! ssh-add -l >/dev/null 2>&1; then
    ssh-add ~/.ssh/github_key_name
fi

# ENVIRONMENT VARIABLES & PATHS

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

export EDITOR=nvim
export VISUAL=nvim
export MANPAGER="nvim +Man!"
export TERMINAL=alacritty
export BROWSER=google-chrome

# Local binaries first
export PATH=/usr/local/bin:$PATH
# System binaries
export PATH=$PATH:/sbin:/usr/sbin
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:$(go env GOPATH)/bin
export PATH="$PATH:/opt/nvim-linux64/bin"

# SOURCING & CUSTOM DEFINITIONS 

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# Cargo and rust environment setup
. "$HOME/.cargo/env"

# Load NVM (Node Version Manager)
export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# Enable color support for ls and add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    
    alias ls='ls --color=auto'
    alias grep='grep -E --color=auto -niI --exclude="*.svg" --exclude-dir={.git,.hg,.svn,node_modules,dist,build}'
    alias fd='fd --regex --color=auto -iHI --exclude ".git" --exclude ".hg" --exclude ".svn" --exclude node_modules --exclude dist --exclude build'
    alias sed='sed -E'
fi

# Aliases
alias history-clean="history -c && history -r && history -w"
alias nviml="NVIM_APPNAME=nvim-lazy nvim"
alias nvims="NVIM_APPNAME=nvim-server nvim"
alias fkill='~/.local/bin/fkill'
alias fcontainer='~/.local/bin/fcontainer'
alias fimage='~/.local/bin/fimage'
alias fvolume='~/.local/bin/fvolume'
alias fnetwork='~/.local/bin/fnetwork'
alias fvideo='~/.local/bin/fvideo'

# Ansible shortcuts
ansiblex() {
  cmd="$1"
  shift
  case "$cmd" in
    encrypt|view|edit)
      ansible-vault "$cmd" --vault-password-file ~/.vault "$@"
      ;;
    rekey)
      ansible-vault rekey --vault-password-file ~/.vault --new-vault-password-file ~/.vault_new "$@"
      ;;
    *)
      echo "Usage: ans {encrypt|view|edit|rekey} file..."
      ;;
  esac
}

# PROMPT AND KEYBINDINGS

eval "$(fzf --zsh)"

xset r rate 300 50

bindkey -v
export KEYTIMEOUT=1

eval "$(starship init zsh)"
export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"

function fsession_widget() {
  ~/.local/bin/fsession
  zle reset-prompt
}

function fmusic_widget() {
  ~/.local/bin/fmusic
  zle reset-prompt
}

zle -N fsession_widget
zle -N fmusic_widget

bindkey -M viins '^f' fsession_widget
bindkey -M viins '^b' fmusic_widget
bindkey -M vicmd '^f' fsession_widget
bindkey -M vicmd '^b' fmusic_widget
