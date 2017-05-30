#-----------------------------
# Prepare base16 colors and basic exports
#-----------------------------
source $HOME/.profile


#-----------------------------
# History
#-----------------------------
HISTFILE=$HOME/.history
HISTSIZE=100000
SAVEHIST=$HISTSIZE


#-----------------------------
# Key bindings
#-----------------------------
bindkey -v


#-----------------------------
# Alias
#-----------------------------
alias :sp='test -n "$TMUX" && tmux split-window'
alias :vs='test -n "$TMUX" && tmux split-window -h'
alias cd..='cd ..'
#alias grep='grep --color=auto' 
alias h=history
#alias ls='ls --color=auto'
#alias ll='ls -lha --color=auto'
alias t=tmux
alias v=vim

if [[ `uname` == 'Linux' ]] then
  alias grep='grep --color=auto'
  alias ls='ls --color=auto'
  alias ll='ls -lha --color=auto'
else
  alias grep='grep -G'
  alias ls='ls -G'
  alias ll='ls -Glha'
fi

#-----------------------------
# Auto completion
#-----------------------------
zstyle :compinstall filename '/home/dvladek/.zshrc'

autoload -Uz compinit
compinit

# Make completion:
# - Case-insensitive.
# - Accept abbreviations after . or _ or - (ie. f.b -> foo.bar).
# - Substring complete (ie. bar -> foobar).
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# Colorize completions using default `ls` colors.
#zstyle ':completion:*' list-colors ''

# Exceptions to auto-correction
alias bundle='nocorrect bundle'
alias man='nocorrect man'
alias mkdir='nocorrect mkdir'
alias mv='nocorrect mv'
alias sudo='nocorrect sudo'


#-----------------------------
# Prompt
#-----------------------------
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git hg
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' stagedstr "%F{green}•%f" # default 'S'
zstyle ':vcs_info:*' unstagedstr "%F{red}•%f" # default 'U'
zstyle ':vcs_info:*' use-simple true
zstyle ':vcs_info:git+set-message:*' hooks git-untracked
zstyle ':vcs_info:git*:*' formats '[%b%m%c%u] ' # default ' (%s)-[%b]%c%u-'
zstyle ':vcs_info:git*:*' actionformats '[%b|%a%m%c%u] ' # default ' (%s)-[%b|%a]%c%u-'
zstyle ':vcs_info:hg*:*' formats '[%m%b] '
zstyle ':vcs_info:hg*:*' actionformats '[%b|%a%m] '
zstyle ':vcs_info:hg*:*' branchformat '%b'
zstyle ':vcs_info:hg*:*' get-bookmarks true
zstyle ':vcs_info:hg*:*' get-revision true
zstyle ':vcs_info:hg*:*' get-mq false
zstyle ':vcs_info:hg*+gen-hg-bookmark-string:*' hooks hg-bookmarks
zstyle ':vcs_info:hg*+set-message:*' hooks hg-message

function +vi-hg-bookmarks() {
  emulate -L zsh
  if [[ -n "${hook_com[hg-active-bookmark]}"  ]]; then
    hook_com[hg-bookmark-string]="${(Mj:,:)@}"
    ret=1
  fi
}

function +vi-hg-message() {
  emulate -L zsh
  # Suppress hg branch display if we can display a bookmark instead.
  if [[ -n "${hook_com[misc]}" ]]; then
    hook_com[branch]=''
  fi
  return 0
}

function +vi-git-untracked() {
  emulate -L zsh
  if [[ -n $(git ls-files --exclude-standard --others 2> /dev/null) ]]; then
    hook_com[unstaged]+="%F{04}•%f"
  fi
}

RPROMPT_BASE="\${vcs_info_msg_0_}%F{04}%1~%f"
setopt PROMPT_SUBST

function () {
  if [[ -n "$TMUX"  ]]; then
    local LVL=$(($SHLVL - 1))
  else
    local LVL=$SHLVL
  fi

  if [[ $EUID -eq 0  ]]; then
    local SUFFIX=$(printf '#%.0s' {1..$LVL})
  else
    local SUFFIX=$(printf '\$%.0s' {1..$LVL})
  fi
  
  if [[ -n "$TMUX"  ]]; then
    # Note use a non-breaking space at the end of the prompt because we can use it as
    # a find pattern to jump back in tmux.
    local NBSP=' '
    #export PS1="%F{green}${SSH_TTY:+%n@%m}%f%B${SSH_TTY:+:}%b%F{blue}%1~%F{yellow}%B%(1j.*.)%(?..!)%b%f%F{red}%B${SUFFIX}%b%f${NBSP}"
    export PS1="%F{green}${SSH_TTY:+%n@%m}%f%B${SSH_TTY:+:}%b%F{08}%n%f%F{03}%B%(1j.*.)%(?..!)%b%f${SUFFIX}${NBSP}"
    export ZLE_RPROMPT_INDENT=0
  else
    # Don't bother with ZLE_RPROMPT_INDENT here, because it ends up eating the
    # space after PS1.
    #export PS1="%F{green}${SSH_TTY:+%n@%m}%f%B${SSH_TTY:+:}%b%F{blue}%1~%F{yellow}%B%(1j.*.)%(?..!)%b%f%F{red}%B${SUFFIX}%b%f "
    export PS1="%F{green}${SSH_TTY:+%n@%m}%f%B${SSH_TTY:+:}%b%F{08}%n%f%F{03}%B%(1j.*.)%(?..!)%b%f${SUFFIX} "
  fi
}


export RPROMPT=$RPROMPT_BASE
export SPROMPT="zsh: correct %F{16}'%R'%f to %F{03}'%r'%f [%B%Uy%u%bes, %B%Un%u%bo, %B%Ue%u%bdit, %B%Ua%u%bbort]? "



#-----------------------------
# Hooks
#-----------------------------
autoload -U add-zsh-hook

typeset -F SECONDS
function record-start-time() {
  emulate -L zsh
  ZSH_START_TIME=${ZSH_START_TIME:-$SECONDS}
}

function report-start-time() {
  emulate -L zsh
  if [ $ZSH_START_TIME  ]; then
    local DELTA=$(($SECONDS - $ZSH_START_TIME))
    local DAYS=$((~~($DELTA / 86400)))
    local HOURS=$((~~(($DELTA - $DAYS * 86400) / 3600)))
    local MINUTES=$((~~(($DELTA - $DAYS * 86400 - $HOURS * 3600) / 60)))
    local SECS=$(($DELTA - $DAYS * 86400 - $HOURS * 3600 - $MINUTES * 60))
    local ELAPSED=''
    test "$DAYS" != '0' && ELAPSED="${DAYS}d"
    test "$HOURS" != '0' && ELAPSED="${ELAPSED}${HOURS}h"
    test "$MINUTES" != '0' && ELAPSED="${ELAPSED}${MINUTES}m"
    if [ "$ELAPSED" = ''  ]; then
      SECS="$(print -f "%.2f" $SECS)s"
    elif [ "$DAYS" != '0'  ]; then	
      SECS=''
    else
      SECS="$((~~$SECS))s"
    fi
    ELAPSED="${ELAPSED}${SECS}"
    local ITALIC_ON=$'\e[3m'
    local ITALIC_OFF=$'\e[23m'
    export RPROMPT="%F{cyan}%{$ITALIC_ON%}${ELAPSED}%{$ITALIC_OFF%}%f $RPROMPT_BASE"
    unset ZSH_START_TIME
  else
    export RPROMPT="$RPROMPT_BASE"
  fi
}

# Currently not used
function auto-ls-after-cd() {
  emulate -L zsh
  # Only in response to a user-initiated `cd`, not indirectly (eg. via another
  # function).
  if [ "$ZSH_EVAL_CONTEXT" = "toplevel:shfunc" ]; then
    ls -a
  fi
}

add-zsh-hook preexec record-start-time

add-zsh-hook precmd report-start-time
add-zsh-hook precmd vcs_info
#add-zsh-hook chpwd auto-ls-after-cd


#-----------------------------
# Options
#-----------------------------
setopt autocd 		    # .. is shortcut for cd .. (etc)
setopt autoparamslash       # tab completing directory appends a slash
setopt autopushd            # cd automatically pushes old dir onto dir stack
setopt correct              # command auto-correction
setopt correctall           # argument auto-correction
setopt histignorealldups    # filter duplicates from history
setopt histignorespace      # don't record commands starting with a space
setopt histverify 	    # confirm history expansion (!$, !!, !foo)
setopt interactivecomments  # allow comments, even in interactive shells
setopt pushdignoredups      # don't push multiple copies of same dir onto stack
setopt pushdsilent          # don't print dir stack after pushing/popping
setopt sharehistory 	    # share history across shells

