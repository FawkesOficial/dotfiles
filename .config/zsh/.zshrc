#!/bin/zsh

# Launch DM/WM automatically on TTY
#[ "$(tty)" = "/dev/tty1" ] && ! pidof -s Xorg >/dev/null 2>&1 && startx         # deprecated; using Wayland (Hyprland) now
[ "$(tty)" = "/dev/tty1" ] && ! pidof -s Hyprland >/dev/null 2>&1 && $XDG_CONFIG_HOME/x11/xinitrc

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

#export PROMPT="[%n@%m %~]$ "
eval "$(starship init zsh)"

(cat ~/.cache/wal/sequences &)

# Load syntax highlighting; should be last.
source $ZDOTDIR/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh 2>/dev/null
