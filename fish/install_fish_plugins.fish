#!/usr/bin/env fish

curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher

fisher update

# This needs to run whenver we upgrade tide
# or we just want to reset it.
tide configure --auto \
  --style='Lean' \
  --prompt_colors='True color' \
  --show_time='24-hour format' \
  --lean_prompt_height='Two lines' \
  --prompt_connection=Disconnected \
  --prompt_spacing=Sparse \
  --icons='Many icons' \
  --transient=Yes

set -U tide_left_prompt_items os pwd git jj newline character
set -U tide_jj_bg_color normal
