# Error-sound-on-terminal

🔊 Play a sound when a command fails in the terminal — shell hook that alerts you on errors (zsh & bash)

## Installation

### Option 1: Manual

1. Add your preferred error sound as `error.mp3` in this directory (or use the included one).
2. Run:
   ```bash
   ./install.sh
   ```
3. Restart your terminal or `source ~/.zshrc` / `source ~/.bashrc`.

### Option 2: Homebrew

```bash
brew tap FranPerru/error-sound-on-terminal
brew install faaaah
```

Then run the install script to configure your shell:
```bash
/opt/homebrew/opt/faaaah/install.sh
```

## Uninstallation

```bash
./uninstall.sh
```

## Requirements

- zsh or bash
- A command to play audio (e.g. `afplay` on macOS, `mpv`/`paplay` on Linux)

## Configuration

Copy `config.example` to `~/.faaaah/config` to customize:

| Variable | Description | Default |
|----------|-------------|---------|
| `FAAAAH_SOUND` | Path to error sound file | `~/.faaaah/error.mp3` |
| `FAAAAH_LOG` | Enable logging (0 or 1) | `0` |
| `FAAAAH_LOG_FILE` | Log file path when logging enabled | `~/.faaaah/faaaah.log` |

### Example config

```bash
# ~/.faaaah/config
FAAAAH_SOUND="${HOME}/.faaaah/error.mp3"
FAAAAH_LOG=1
FAAAAH_LOG_FILE="${HOME}/.faaaah/faaaah.log"
```

## How it works

The hook uses shell-specific mechanisms to detect when a command fails (non-zero exit code) and plays `error.mp3` automatically. Supports both zsh (precmd hook) and bash (PROMPT_COMMAND).

## License

MIT
