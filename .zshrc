# ZSH FRAMEWORK CONFIGURATION 
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"

plugins=(
    zsh-syntax-highlighting
    # zsh-autosuggestions
    zsh-vi-mode
)

# CUSTOM SYNTAX HIGHLIGHTING (ROSE PINE MOON HARMONY)
typeset -A ZSH_HIGHLIGHT_STYLES

# 1. COMMANDS & ALIASES — Primary action: Pine (Teal/Blue)
ZSH_HIGHLIGHT_STYLES[command]='fg=#31748f,bold'
ZSH_HIGHLIGHT_STYLES[alias]='fg=#31748f,bold'

# 2. BUILTINS & RESERVED WORDS — Slightly different blue
ZSH_HIGHLIGHT_STYLES[builtin]='fg=#56949f,bold'
ZSH_HIGHLIGHT_STYLES[reserved-word]='fg=#56949f,bold'

# 3. FUNCTIONS — Foam (Light Cyan)
ZSH_HIGHLIGHT_STYLES[function]='fg=#9ccfd8'

# 4. UNKNOWN / ERROR — Rose for errors
ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=#eb6f92,bold'

# 5. OPTIONS / FLAGS — Gold
ZSH_HIGHLIGHT_STYLES[precommand]='fg=#f6c177'
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=#f6c177'
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=#f6c177'

# 6. PATHS / DIRECTORIES — Muted gray
ZSH_HIGHLIGHT_STYLES[path]='fg=#6e6a86'
ZSH_HIGHLIGHT_STYLES[path_prefix]='fg=#6e6a86'

# 7. VARIABLES — Iris purple
ZSH_HIGHLIGHT_STYLES[dollar-variable]='fg=#c4a7e7'

# 8. PARAMETERS — Different purple shade
ZSH_HIGHLIGHT_STYLES[param]='fg=#908caa'

# 9. COMMENTS — Muted gray with italic
ZSH_HIGHLIGHT_STYLES[comment]='fg=#6e6a86,italic'

# 10. REDIRECTION — Different red shade
ZSH_HIGHLIGHT_STYLES[redirection]='fg=#b4637a' 

# 11. STRINGS / QUOTES — Foam greenish-cyan
ZSH_HIGHLIGHT_STYLES[quotation]='fg=#9ccfd8'        
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=#9ccfd8'
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=#9ccfd8'

# 12. NUMBERS / CONSTANTS — Peach/orange
ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter]='fg=#ea9d34'
ZSH_HIGHLIGHT_STYLES[arithmetic-expansion]='fg=#ea9d34'    
ZSH_HIGHLIGHT_STYLES[number]='fg=#ea9d34'

# 13. GLOBS / WILDCARDS — Different blue shade
ZSH_HIGHLIGHT_STYLES[globbing]='fg=#286983' 

# 14. VI MODE REGION 
ZSH_HIGHLIGHT_STYLES[region]='bg=#393552'

# 15. VARIABLE ASSIGNMENTS — Different purple
ZSH_HIGHLIGHT_STYLES[assign]='fg=#e0def4'

# 16. BACKQUOTES / COMMAND SUBSTITUTION — Gold
ZSH_HIGHLIGHT_STYLES[back-quoted-argument]='fg=#f6c177'

# 17. UNCLOSED / ERRORS — Rose red
ZSH_HIGHLIGHT_STYLES[back-quoted-argument-unclosed]='fg=#eb6f92'
ZSH_HIGHLIGHT_STYLES[command-substitution-unclosed]='fg=#eb6f92'

export ZVM_CURSOR_STYLE_ENABLED=false

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
export BAT_PAGER="less -R"
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

# Enable color support for ls
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
fi

# Only in the interactive shell NOT IN Scripts 
if [[ $- == *i* ]]; then
    # Addons include (-r, -l,-c number, -v(for inverse)) 
    alias grep='grep -E --color=auto -niI --exclude="*.svg" --exclude-dir={.git,.hg,.svn,node_modules,dist,build}'

    # Addons include (-t (with the following options:f, d, l, b, c, s, p, x, e)) 
    alias fd='fd --regex --color=auto -iHI --exclude .git --exclude .hg --exclude .svn --exclude node_modules --exclude dist --exclude build'

    #Addons for awk no -E arguments so not alias required
    alias sed='sed -E'

    # Addons: --delete (mirror source with destination), --dry-run (preview), -u (update only newer), --exclude (skip files)
    alias rsync='rsync -avh --progress --partial --inplace --human-readable --info=stats1,progress2 --compress --rsh=ssh'

    # Use bat instead of cat with syntax highlighting and paging
    alias cat='bat --style=plain --paging=always --decorations=always --color=always'
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

if [[ $- == *i* ]]; then
  eval "$(fzf --zsh)"
fi

xset r rate 300 50

# not needed since am using a plugin for vi mode
# bindkey -v
export KEYTIMEOUT=1

if [[ $- == *i* ]]; then
  eval "$(starship init zsh)"
fi

export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"

function fsession_widget() {
  ~/.local/bin/fsession
  zle reset-prompt
}

function fmusic_widget() {
  ~/.local/bin/fmusic
  zle reset-prompt
}

function fzf-history-widget() {
  BUFFER=$(fc -l -n 1 | fzf --height 40% --border --query="$LBUFFER")
  CURSOR=$#BUFFER
  zle reset-prompt
}

zle -N fsession_widget
zle -N fmusic_widget
zle -N fzf-history-widget

zvm_after_init() {
  bindkey -M viins '^f' fsession_widget
  bindkey -M viins '^b' fmusic_widget
  bindkey -M vicmd '^f' fsession_widget
  bindkey -M vicmd '^b' fmusic_widget
  bindkey -M viins '^R' fzf-history-widget
  bindkey -M vicmd '^R' fzf-history-widget
}
