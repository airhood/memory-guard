# memory-guard

`memory-guard` checks system memory every 10 seconds and posts a desktop notification when memory is running low. It uses Linux's estimate of available RAM, which includes memory it can reclaim. Inactive pages can stay in swap while the desktop is responsive.

A warning appears when available RAM (rounded down to a whole percent) falls to 3% or below, or when it falls to 8% or below and either of these conditions applies.

- Memory pressure stalls one or more tasks for at least 5% of the last 10 seconds, as reported by Linux PSI.
- Configured swap has 10% or less space left.

The warning repeats only after available RAM recovers to at least 12% and then falls again. The tool only sends a notification. Memory can run out between checks, and a desktop that has already frozen may miss the notification.

## Requirements

- A Linux desktop running a systemd user session, with Bash and `MemAvailable` in `/proc/meminfo`
- Git to clone the repository
- A graphical desktop with a notification service and `notify-send` (provided by `libnotify-bin` on Ubuntu)
- Linux memory PSI for the pressure-based trigger. The remaining triggers also work without PSI.

## Install

On Ubuntu or Debian, install Git and the desktop notification command if needed.

```bash
sudo apt install git libnotify-bin
```

From a terminal in your desktop session, install memory-guard as your regular user.

```bash
git clone https://github.com/airhood/memory-guard.git
cd memory-guard
./install.sh
~/.local/bin/memory-guard status
```

The installer copies the files to `~/.local/bin`, `~/.local/libexec/memory-guard`, and the systemd user configuration directory, then starts and enables the timer. Use `~/.local/bin/memory-guard` if that directory is outside your PATH.

## Preview a notification

Run this from your desktop session to check that notifications appear.

```bash
notify-send --app-name=memory-guard --urgency=critical \
  'System memory is low (preview)' 'Available RAM: 3%. Free swap: 128 MiB.'
```

## Use

```bash
memory-guard start
memory-guard stop
memory-guard status
journalctl --user -u memory-guard.service
```

Run `./uninstall.sh` from the cloned repository to remove the tool.

This project is available under the MIT License.
