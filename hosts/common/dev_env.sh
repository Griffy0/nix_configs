#!/usr/bin/env bash
# start-tmux-dev.sh

SESSION="dev"

# If the session already exists, just attach to it
if tmux has-session -t "$SESSION" 2>/dev/null; then
    exec tmux attach -t "$SESSION"
fi

# Create a new detached session with vi in the first pane
tmux new-session -d -s "$SESSION" -n editor 'vi ./'

# Give tmux a short moment to create the session before splitting
sleep 0.1

# Split horizontally (side-by-side)
tmux split-window -h -t "$SESSION":editor

# Run clang on the right
# tmux send-keys -t "$SESSION":editor.1 'clang' C-m

# Focus back to vim pane
tmux select-pane -t "$SESSION":editor.0

# Attach to the session
tmux attach -t "$SESSION"

