#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
INSTALL_DIR="${HOME}/.faaaah"
HOOK_FILE="${INSTALL_DIR}/hook.zsh"
ZSHRC="${HOME}/.zshrc"

echo "Installing FAAAAH..."
mkdir -p "${INSTALL_DIR}"
cp -r "${SCRIPT_DIR}/src/"* "${INSTALL_DIR}/"
[ -f "${SCRIPT_DIR}/error.mp3" ] && cp "${SCRIPT_DIR}/error.mp3" "${INSTALL_DIR}/"

if ! grep -q "source.*faaaah.*hook.zsh" "${ZSHRC}" 2>/dev/null; then
    echo "" >> "${ZSHRC}"
    echo "# FAAAAH - Play sound on command error" >> "${ZSHRC}"
    echo "source \"${HOOK_FILE}\"" >> "${ZSHRC}"
    echo "Added FAAAAH to ${ZSHRC}"
else
    echo "FAAAAH is already configured in ${ZSHRC}"
fi

echo "Installation complete. Restart your terminal or run: source ${ZSHRC}"
