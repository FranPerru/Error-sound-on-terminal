# FAAAAH - Play sound when command fails
_faaaah_precmd() {
    local exit_code=$?
    if [[ $exit_code -ne 0 ]]; then
        local sound_file="${FAAAAH_SOUND:-${HOME}/.faaaah/error.mp3}"
        if [[ -f "$sound_file" ]]; then
            if command -v afplay &>/dev/null; then
                afplay "$sound_file" &>/dev/null &
            elif command -v mpv &>/dev/null; then
                mpv --no-terminal --no-video "$sound_file" &>/dev/null &
            elif command -v paplay &>/dev/null; then
                paplay "$sound_file" &>/dev/null &
            fi
        fi
    fi
}

autoload -Uz add-zsh-hook
add-zsh-hook precmd _faaaah_precmd
