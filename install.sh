#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
INSTALL_DIR="${HOME}/.faaaah"

# Detect current shell (default to zsh if not determinable)
if [[ -n "$ZSH_VERSION" ]]; then
    DETECTED_SHELL="zsh"
elif [[ -n "$BASH_VERSION" ]]; then
    DETECTED_SHELL="bash"
else
    # Fallback: use parent process or default
    DETECTED_SHELL="${SHELL##*/}"
    [[ "$DETECTED_SHELL" != "zsh" && "$DETECTED_SHELL" != "bash" ]] && DETECTED_SHELL="zsh"
fi

echo "Installing FAAAAH..."
echo "Detected shell: $DETECTED_SHELL"

mkdir -p "${INSTALL_DIR}"
cp -r "${SCRIPT_DIR}/src/"* "${INSTALL_DIR}/"
[ -f "${SCRIPT_DIR}/error.mp3" ] && cp "${SCRIPT_DIR}/error.mp3" "${INSTALL_DIR}/"

# Install config from example if no config exists
if [[ ! -f "${INSTALL_DIR}/config" ]] && [[ -f "${SCRIPT_DIR}/config.example" ]]; then
    cp "${SCRIPT_DIR}/config.example" "${INSTALL_DIR}/config"
    echo "Created config at ${INSTALL_DIR}/config"
fi

add_to_shell_config() {
    local rc_file="$1"
    local hook_file="$2"
    local shell_type="$3"

    if [[ ! -f "$rc_file" ]]; then
        touch "$rc_file"
    fi

    if grep -q "source.*faaaah.*hook\." "$rc_file" 2>/dev/null; then
        echo "FAAAAH is already configured in $rc_file"
    else
        echo "" >> "$rc_file"
        echo "# FAAAAH - Play sound on command error" >> "$rc_file"
        echo "source \"${hook_file}\"" >> "$rc_file"
        echo "Added FAAAAH to $rc_file"
    fi
}

if [[ "$DETECTED_SHELL" == "zsh" ]]; then
    add_to_shell_config "${HOME}/.zshrc" "${INSTALL_DIR}/hook.zsh" "zsh"
    echo "Restart your terminal or run: source ~/.zshrc"
elif [[ "$DETECTED_SHELL" == "bash" ]]; then
    add_to_shell_config "${HOME}/.bashrc" "${INSTALL_DIR}/hook.bash" "bash"
    echo "Restart your terminal or run: source ~/.bashrc"
else
    echo "Unsupported shell: $DETECTED_SHELL. Attempting zsh config..."
    add_to_shell_config "${HOME}/.zshrc" "${INSTALL_DIR}/hook.zsh" "zsh"
fi

echo "Installation complete."
