#!/usr/bin/env bash
set -euo pipefail
cd -- "$(dirname -- "${BASH_SOURCE[0]}")"

for dependency in awk notify-send systemctl; do
    command -v "$dependency" >/dev/null || { echo "Missing command: $dependency" >&2; exit 1; }
done

unit_dir="${XDG_CONFIG_HOME:-$HOME/.config}/systemd/user"
install -Dm755 bin/memory-guard "$HOME/.local/bin/memory-guard"
install -Dm755 libexec/check "$HOME/.local/libexec/memory-guard/check"
install -Dm644 systemd/memory-guard.service "$unit_dir/memory-guard.service"
install -Dm644 systemd/memory-guard.timer "$unit_dir/memory-guard.timer"
systemctl --user daemon-reload
systemctl --user enable --now memory-guard.timer
