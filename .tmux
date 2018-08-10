#!/bin/sh
#
# Attach or create tmux session named the same as current directory.

set -e

BASEDIR=$(basename $PWD)

if tmux has-session -t=$BASEDIR 2> /dev/null; then
    tmux attach -t=$BASEDIR
  exit
fi

tmux new-session -d -s $BASEDIR -n vim -x $(tput cols) -y $(tput lines)

tmux send-keys -t=$($BASEDIR):vim "sleep .25; vim" Enter
tmux split-window -t=$($BASEDIR):vim -h
tmux split-window -t=$($BASEDIR):vim -v

tmux attach -t=$($BASEDIR):vim.left
