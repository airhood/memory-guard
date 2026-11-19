# memory-guard

`memory-guard` checks system memory every 10 seconds and posts a desktop notification when memory is running low. It uses Linux's estimate of available RAM, which includes memory it can reclaim. Inactive pages can stay in swap while the desktop is responsive.

A warning appears when available RAM (rounded down to a whole percent) falls to 3% or below, or when it falls to 8% or below and either of these conditions applies.

- Memory pressure stalls one or more tasks for at least 5% of the last 10 seconds, as reported by Linux PSI.
- Configured swap has 10% or less space left.

The warning repeats only after available RAM recovers to at least 12% and then falls again. The tool only sends a notification. Memory can run out between checks, and a desktop that has already frozen may miss the notification.

## Requirements

- Linux with `MemAvailable` in `/proc/meminfo`, Bash, and a systemd user session
- A graphical desktop with a notification service and `notify-send` (provided by `libnotify-bin` on Ubuntu)
- Linux memory PSI for the pressure-based trigger. The remaining triggers also work without PSI.

## Install

Run these commands from your graphical user session. No sudo is required for installation when the dependencies are present.

```bash
git clone https://github.com/airhood/memory-guard.git
cd memory-guard
./install.sh
```

The installer copies the files to `~/.local/bin`, `~/.local/libexec/memory-guard`, and the systemd user configuration directory, then starts and enables the timer. Use `~/.local/bin/memory-guard` if that directory is outside your PATH.

## Use

```bash
memory-guard start
memory-guard stop
memory-guard status
journalctl --user -u memory-guard.service
```

Run `./uninstall.sh` from the cloned repository to remove the tool.

This project is available under the MIT License.
