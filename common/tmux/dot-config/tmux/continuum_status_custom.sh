##!/bin/bash
#
#last_save_file="$HOME/.local/share/tmux/resurrect/last"
#
#if [ -f "$last_save_file" ]; then
#  # Detect OS
#  if [[ "$OSTYPE" == "darwin"* ]]; then
#    # macOS uses BSD stat
#    last_save_time=$(stat -f "%Sm" -t "%H:%M" "$last_save_file")
#  else
#    # Linux uses GNU stat
#    last_save_time=$(stat -c "%y" "$last_save_file" | awk '{print substr($2,1,5)}')
#  fi
#  echo "💾 last saved $last_save_time"
#else
#  echo "💾 off"
#fi
#!/bin/bash

last_save_file="$HOME/.local/share/tmux/resurrect/last"

if [ -f "$last_save_file" ]; then
  last_save_time=$(date -r "$last_save_file" +"%H:%M" 2>/dev/null || date -d @"$(stat -c %Y "$last_save_file")" +"%H:%M")
  echo "💾 last saved $last_save_time"
else
  echo "💾 off"
fi
