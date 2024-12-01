#!/bin/zsh

[ "$(tty)" = "/dev/tty1" ] && ! pidof -s Xorg >/dev/null 2>&1 && startx

CONFIG="$ZDOTDIR/.zshrc"

alias zsh-reload="source $CONFIG"
alias zsh-edit-config="vim $CONFIG"

#set enable-keypad on
stty -ixon # Disable ctrl-s and ctrl-q.
#set -o vi # vi mode
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

zstyle ':completion:*' completer _complete _ignored
zstyle ':completion:*' list-colors ''
zstyle :compinstall filename '$ZDOTDIR/.zshrc'

autoload -Uz compinit
compinit
HISTFILE=$XDG_CACHE_HOME/zsh_history
HISTSIZE=5000
SAVEHIST=$HISTSIZE
unsetopt beep
setopt hist_ignore_all_dups
setopt autocd

first-tab() {
    if [[ $#BUFFER == 0 ]]; then
        BUFFER="cd "
        CURSOR=3
        zle list-choices
    else
        zle expand-or-complete
    fi
}
zle -N first-tab
bindkey '^I' first-tab

# Load shell aliases
[ -f "$XDG_CONFIG_HOME/shell/aliasrc" ] && source "$XDG_CONFIG_HOME/shell/aliasrc"

eval "$(starship init zsh)"
#export PROMPT="[%n@%m %~]$ "

# yazi (file manager)
function y() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
    yazi "$@" --cwd-file="$tmp"
    if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
        builtin cd -- "$cwd"
    fi
    rm -f -- "$tmp" > /dev/null
}

# zoxide (smart cd)
eval "$(zoxide init zsh)"

alias cd="z"

# fzf (smart completion)
eval "$(fzf --zsh)"

# -- Use fd instead of fzf --

export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

# Use fd (https://github.com/sharkdp/fd) for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --exclude .git . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type=d --hidden --exclude .git . "$1"
}

show_file_or_dir_preview="if [ -d {} ]; then eza --tree --color=always {} | head -200; else bat -n --color=always --line-range :500 {}; fi"

export FZF_CTRL_T_OPTS="--preview '$show_file_or_dir_preview'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

# Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments to fzf.
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
    export|unset) fzf --preview "eval 'echo \${}'"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview "$show_file_or_dir_preview" "$@" ;;
  esac
}

# bat (better cat)
export BAT_THEME="base16"

# Load syntax highlighting; should be last.
source $ZDOTDIR/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh 2>/dev/null
