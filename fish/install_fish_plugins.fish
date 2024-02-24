#!/usr/bin/env fish

curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher

fisher update

tide configure --auto \
  --style='One line' \
  --prompt_colors='True color' \
  --show_time='24-hour format' \
  --lean_prompt_height='Two lines' \
  --prompt_connection=Disconnected \
  --prompt_spacing=Sparse \
  --icons='Many icons' \
  --transient=Yes

