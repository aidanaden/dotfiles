#!/usr/bin/env bash

command=`cat $HOME/.tmux-launcher-apps | fzf`
command_name="$command-app"
tmux_running=$(pgrep tmux)

if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
    tmux new-session -A -s $command_name "$command"
    exit 0
fi

if ! tmux has-session -t=$command_name 2> /dev/null; then
    tmux new-session -ds $command_name "$command"
fi

if [[ -z $TMUX ]]; then
    tmux attach-session -t $command_name
else
    tmux switch-client -t $command_name
fi
