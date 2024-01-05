#!/bin/sh
echo -ne '\033c\033]0;Liquidation Dash\a'
base_path="$(dirname "$(realpath "$0")")"
"$base_path/Liquidation Dash.x86_64" "$@"
