# Error-sound-on-terminal

🔊 Play a sound when a command fails in the terminal — zsh hook that alerts you on errors

## Installation

1. Add your preferred error sound as `error.mp3` in this directory (or use the included one).
2. Run:
   ```bash
   ./install.sh
   ```
3. Restart your terminal or `source ~/.zshrc`.

## Uninstallation

```bash
./uninstall.sh
```

## Requirements

- zsh
- A command to play audio (e.g. `afplay` on macOS, `mpv`/`paplay` on Linux)

## How it works

The `hook.zsh` script uses zsh hooks to detect when a command fails (non-zero exit code) and plays `error.mp3` automatically.
