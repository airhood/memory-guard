#!/usr/bin/env bash
set -euo pipefail
unit_dir="${XDG_CONFIG_HOME:-$HOME/.config}/systemd/user"
systemctl --user disable --now memory-guard.timer
systemctl --user stop memory-guard.service
rm -f -- "$unit_dir/memory-guard.timer" "$unit_dir/memory-guard.service" \
    "$HOME/.local/bin/memory-guard" "$HOME/.local/libexec/memory-guard/check"
systemctl --user daemon-reload
