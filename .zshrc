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

# ZSH SYNTAX HIGHLIGHTING COMPLETE CONFIGURATION

# COMMANDS & ALIASES & Functions
ZSH_HIGHLIGHT_STYLES[command]='fg=#31748f,bold'
ZSH_HIGHLIGHT_STYLES[alias]='fg=#31748f,bold'
ZSH_HIGHLIGHT_STYLES[function]='fg=#31748f,bold'
ZSH_HIGHLIGHT_STYLES[global-alias]='fg=#31748f,bold'
ZSH_HIGHLIGHT_STYLES[suffix-alias]='fg=#31748f,bold'

# BUILTINS & RESERVED WORDS
ZSH_HIGHLIGHT_STYLES[builtin]='fg=#56949f,bold'
ZSH_HIGHLIGHT_STYLES[reserved-word]='fg=#56949f,bold'

# OPTIONS / FLAGS
ZSH_HIGHLIGHT_STYLES[precommand]='fg=#f6c177,bold'
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=#f6c177,bold'
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=#f6c177,bold'

# GLOBS / WILDCARDS
ZSH_HIGHLIGHT_STYLES[globbing]='fg=#6e6a86,bold'

# PATHS / DIRECTORIES
ZSH_HIGHLIGHT_STYLES[path]='fg=#95b1ac,bold'
ZSH_HIGHLIGHT_STYLES[path_prefix]='fg=#95b1ac,bold'
ZSH_HIGHLIGHT_STYLES[path_pathseparator]='fg=#95b1ac,bold'
ZSH_HIGHLIGHT_STYLES[path_prefix_pathseparator]='fg=#95b1ac,bold'

# QUOTES & STRINGS
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=#eb6f92,bold'
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=#ea9a97,bold'
ZSH_HIGHLIGHT_STYLES[back-quoted-argument]='fg=#6e6a86,bold'
ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument]='fg=#95b1ac,bold'
ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]='fg=#908caa'
ZSH_HIGHLIGHT_STYLES[back-dollar-quoted-argument]='fg=#908caa'
ZSH_HIGHLIGHT_STYLES[quotation]='fg=#56949f,bold'
ZSH_HIGHLIGHT_STYLES[rc-quote]='fg=#908caa,bold'

# COMMAND SUBSTITUTION & EXPANSION
ZSH_HIGHLIGHT_STYLES[command-substitution]='fg=#c4a7e7,bold'
ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter]='fg=#ea9d34'
ZSH_HIGHLIGHT_STYLES[arithmetic-expansion]='fg=#ea9d34'
ZSH_HIGHLIGHT_STYLES[history-expansion]='fg=#ea9d34,bold'

# PROCESS SUBSTITUTION
ZSH_HIGHLIGHT_STYLES[process-substitution]='fg=#56949f,bold'
ZSH_HIGHLIGHT_STYLES[process-substitution-delimiter]='fg=#56949f,bold'

# VARIABLES & PARAMETERS
ZSH_HIGHLIGHT_STYLES[dollar-variable]='fg=#c4a7e7'
ZSH_HIGHLIGHT_STYLES[param]='fg=#908caa'
ZSH_HIGHLIGHT_STYLES[assign]='fg=#e0def4'

# NUMBERS & CONSTANTS
ZSH_HIGHLIGHT_STYLES[number]='fg=#ea9d34'

# REDIRECTION & PIPES
ZSH_HIGHLIGHT_STYLES[redirection]='fg=#6e6a86,bold'
ZSH_HIGHLIGHT_STYLES[commandseparator]='fg=#6e6a86,bold'
ZSH_HIGHLIGHT_STYLES[named-fd]='fg=#6e6a86,bold'
ZSH_HIGHLIGHT_STYLES[numeric-fd]='fg=#6e6a86,bold'

# COMMENTS
ZSH_HIGHLIGHT_STYLES[comment]='fg=#6e6a86,italic'

# BRACKETS & PARENS
ZSH_HIGHLIGHT_STYLES[bracket-level-1]='fg=#31748f,bold'
ZSH_HIGHLIGHT_STYLES[bracket-level-2]='fg=#56949f,bold'
ZSH_HIGHLIGHT_STYLES[bracket-level-3]='fg=#ea9d34,bold'
ZSH_HIGHLIGHT_STYLES[bracket-level-4]='fg=#eb6f92,bold'
ZSH_HIGHLIGHT_STYLES[bracket-level-5]='fg=#c4a7e7,bold'

# ERRORS & UNCLOSED
ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=#eb6f92,bold'
ZSH_HIGHLIGHT_STYLES[back-quoted-argument-unclosed]='fg=#eb6f92'
ZSH_HIGHLIGHT_STYLES[command-substitution-unclosed]='fg=#eb6f92'
ZSH_HIGHLIGHT_STYLES[bracket-error]='fg=#eb6f92,bold'

# VI MODE & CURSOR
ZSH_HIGHLIGHT_STYLES[region]='bg=#393552,bold'
ZSH_HIGHLIGHT_STYLES[cursor]='bg=#eb6f92'
ZSH_HIGHLIGHT_STYLES[cursor-matchingbracket]='bg=#393552'

# MISC & FALLBACKS
ZSH_HIGHLIGHT_STYLES[default]='fg=#e0def4'
ZSH_HIGHLIGHT_STYLES[arg0]='fg=#31748f,bold'
ZSH_HIGHLIGHT_STYLES[line]='fg=#e0def4'
ZSH_HIGHLIGHT_STYLES[root]='bg=#eb6f92'

export ZVM_CURSOR_STYLE_ENABLED=false

source $ZSH/oh-my-zsh.sh

# User Configuration starts below the OMZ sourcing

# HISTORY SETTINGS
HISTSIZE=10000
SAVEHIST=20000
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

# Add user's local bin directory FIRST
export PATH="$HOME/.local/bin:/usr/local/bin:$PATH"

# Then the rest of your existing PATH exports:
export PATH="$PATH:/sbin:/usr/sbin"
export PATH="$PATH:/usr/local/go/bin"
export PATH="$PATH:$(go env GOPAPH)/bin"
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
    # Addons: -i (interactive confirm), -r (recursive), -f (force), -v (verbose), -u (update only newer)
    alias cp='cp -v --reflink=auto'

    # Addons: -i (interactive confirm), -f (force), -v (verbose), -u (update only newer)
    alias mv='mv -v'

    # Addons: -i (interactive confirm), -r (recursive dirs), -f (force), -v (verbose)
    alias rm='rm -v --preserve-root'

    # Addons include (-r, -l,-c number, -v(for inverse)) 
    alias grep='grep -E --color=auto -niI --exclude="*.svg" --exclude-dir={.git,.hg,.svn,node_modules,dist,build}'

    # Addons include (-t (with the following options:f, d, l, b, c, s, p, x, e)) 
    alias fd='fd --regex --color=auto -iHI --exclude .git --exclude .hg --exclude .svn --exclude node_modules --exclude dist --exclude build'

    #Addons for awk no -E arguments so not alias required
    alias sed='sed -E'

    # Addons: --delete (mirror source with destination), --dry-run (preview), -u (update only newer), --exclude (skip files)
    alias rsync='rsync -avh --progress --partial --inplace --human-readable --info=stats1,progress2 --compress --rsh=ssh'

    # Addons: -i (custom key), -P (custom port), -vvv (debug), -b (batch file), -o option=value (extra SSH options)
    alias sftp='sftp -C -p -r -q -o ConnectTimeout=10 -o ServerAliveInterval=60 -o ServerAliveCountMax=3'

    # Use bat instead of cat with syntax highlighting and paging
    # alias cat='bat --style=plain --paging=always --decorations=always --color=always'

fi

# ps -efl (all processes) 
# ps -efL (all threads) 
# ps -efljH (all processes tree view) 

# Aliases
alias history-clean="history -c && history -r && history -w"
alias vim="nvim"
alias fkill='~/.local/bin/fkill'
alias fmusic='~/.local/bin/fmusic'
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

# Oauthtool shortcut
authx() {
    secret="$1"

    if [ -z "$secret" ]; then
        echo "Usage: authx SECRETKEY"
        return 1
    fi

    clean_secret=$(echo "$secret" | tr -d ' ')
    oathtool --totp -b "$clean_secret"
}

# Whisperx transcription
segmentx() {
    audio_file="$1"
    speakers="${2:-2}"
    model="${3:-tiny}"
    
    if [ -z "$audio_file" ]; then
        echo "Usage: segmentx AUDIO_FILE [SPEAKERS] [MODEL]"
        return 1
    fi
    
    local venv_path="${WHISPERX_VENV:-$HOME/whisperx_env}"
    
    if [ -z "$VIRTUAL_ENV" ]; then
        source "$venv_path/bin/activate" 2>/dev/null || {
            echo "Error: Could not activate virtual environment at $venv_path"
            return 1
        }
        local should_deactivate=true
    fi
    
    ftranscript.py "$audio_file" \
        --model "$model" \
        --device cpu \
        --compute_type float32 \
        --diarize \
        --min_speakers "$speakers" \
        --max_speakers "$speakers" \
        --highlight_words True \
        --output_format all \
        --hf_token "$HF_TOKEN" \
        --print_progress True
    
    if [ -n "$should_deactivate" ]; then
        deactivate
    fi
}

# Optional: Add alias for convenience
alias whisperx='segmentx'
# PROMPT AND KEYBINDINGS

if [[ $- == *i* ]]; then
  eval "$(fzf --zsh)"
fi

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

function fzf-history-widget() {
  BUFFER=$(fc -l -n 1 | fzf --height 40% --border --query="$LBUFFER")
  CURSOR=$#BUFFER
  zle reset-prompt
}

zle -N fsession_widget
zle -N fzf-history-widget

zvm_after_init() {
  bindkey -M viins '^g' fsession_widget
  bindkey -M vicmd '^g' fsession_widget
  bindkey -M viins '^r' fzf-history-widget
  bindkey -M vicmd '^r' fzf-history-widget
}

# bun completions
[ -s "/home/kifanga/.bun/_bun" ] && source "/home/kifanga/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# opencode
export PATH=/home/kifanga/.opencode/bin:$PATH


# Added by Antigravity CLI installer
export PATH="/home/kifanga/.local/bin:$PATH"
