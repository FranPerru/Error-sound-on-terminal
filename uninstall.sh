#!/bin/bash
set -e

INSTALL_DIR="${HOME}/.faaaah"
ZSHRC="${HOME}/.zshrc"

echo "Uninstalling FAAAAH..."
rm -rf "${INSTALL_DIR}"

if [ -f "${ZSHRC}" ]; then
    if grep -q "FAAAAH" "${ZSHRC}"; then
        sed -i.bak '/# FAAAAH.*Play sound on command error/d' "${ZSHRC}"
        sed -i.bak "\|source.*faaaah.*hook.zsh|d" "${ZSHRC}"
        rm -f "${ZSHRC}.bak"
        echo "Removed FAAAAH from ${ZSHRC}"
    fi
fi

echo "Uninstall complete. Restart your terminal or run: source ${ZSHRC}"
