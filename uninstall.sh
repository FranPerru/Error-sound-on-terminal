#!/bin/bash
set -e

INSTALL_DIR="${HOME}/.faaaah"

echo "Uninstalling FAAAAH..."
rm -rf "${INSTALL_DIR}"

remove_from_file() {
    local rc_file="$1"
    if [[ -f "$rc_file" ]]; then
        if grep -q "FAAAAH" "$rc_file"; then
            if [[ "$(uname)" == "Darwin" ]]; then
                sed -i.bak '/# FAAAAH.*Play sound on command error/d' "$rc_file"
                sed -i.bak '\|source.*faaaah.*hook\.|d' "$rc_file"
            else
                sed -i '/# FAAAAH.*Play sound on command error/d' "$rc_file"
                sed -i '\|source.*faaaah.*hook\.|d' "$rc_file"
            fi
            rm -f "${rc_file}.bak"
            echo "Removed FAAAAH from $rc_file"
        fi
    fi
}

remove_from_file "${HOME}/.zshrc"
remove_from_file "${HOME}/.bashrc"

echo "Uninstall complete. Restart your terminal or run: source ~/.zshrc (or ~/.bashrc)"
