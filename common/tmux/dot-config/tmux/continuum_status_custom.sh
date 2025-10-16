#!/bin/bash
last_save_file="$HOME/.local/share/tmux/resurrect/last"
if [ -f "$last_save_file" ]; then
  last_save_time=$(stat -f "%Sm" -t "%H:%M" "$last_save_file")
  echo "💾 last saved $last_save_time"
else
  echo "💾 off"
fi