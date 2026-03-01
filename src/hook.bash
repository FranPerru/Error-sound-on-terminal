# FAAAAH - Play sound when command fails (bash)
# Load config if present
[[ -f "${HOME}/.faaaah/config" ]] && source "${HOME}/.faaaah/config"

_faaaah_prompt_command() {
    local exit_code=$?
    if [[ $exit_code -ne 0 ]]; then
        local sound_file="${FAAAAH_SOUND:-${HOME}/.faaaah/error.mp3}"
        if [[ -f "$sound_file" ]]; then
            if command -v afplay &>/dev/null 2>&1; then
                afplay "$sound_file" &>/dev/null &
            elif command -v mpv &>/dev/null 2>&1; then
                mpv --no-terminal --no-video "$sound_file" &>/dev/null &
            elif command -v paplay &>/dev/null 2>&1; then
                paplay "$sound_file" &>/dev/null &
            fi
        fi
        if [[ "${FAAAAH_LOG:-0}" == "1" ]]; then
            echo "$(date '+%Y-%m-%d %H:%M:%S') [$$] exit=$exit_code" >> "${FAAAAH_LOG_FILE:-${HOME}/.faaaah/faaaah.log}"
        fi
    fi
}

# Append to existing PROMPT_COMMAND if set
if [[ -n "$PROMPT_COMMAND" ]]; then
    PROMPT_COMMAND="${PROMPT_COMMAND}; _faaaah_prompt_command"
else
    PROMPT_COMMAND="_faaaah_prompt_command"
fi
