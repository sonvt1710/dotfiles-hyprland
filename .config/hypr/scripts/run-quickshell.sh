#!/usr/bin/env bash

BASE_WIDTH=1920
QS_PATH="$HOME/.config/quickshell/cartoon-shell"

# Lấy monitor đầu tiên
read WIDTH SCALE <<<$(
  hyprctl monitors -j | jq -r '.[0] | "\(.width) \(.scale)"'
)

# Tính scale bằng awk (float OK)
FINAL_SCALE=$(awk -v w="$WIDTH" -v b="$BASE_WIDTH" -v s="$SCALE" \
  'BEGIN { printf "%.3f", (w/b)/s }')

export QML_XHR_ALLOW_FILE_READ=1
export QT_SCALE_FACTOR="$FINAL_SCALE"

exec quickshell --path "$QS_PATH"
