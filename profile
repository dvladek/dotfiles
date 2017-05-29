export PATH=$PATH:/usr/local/go/bin 
export GOPATH=$HOME/Development/gocode
export PATH=$HOME/Development/gocode/bin/:$PATH

export TERM=xterm-256color

# Base16 Shell
BASE16_SHELL="$HOME/.config/base16-shell/
[ -n "$PS1"   ] && [ -s $BASE16_SHELL/profile_helper.sh   ] && eval "$($BASE16_SHELL/profile_helper.sh)"

# set PATH so it includes user's private bin directories                        
PATH="$HOME/bin:$HOME/.local/bin:$PATH"
