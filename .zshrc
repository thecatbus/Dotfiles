export PATH="$PATH:/Users/parth/.local/bin"
[ -f "${GHCUP_INSTALL_BASE_PREFIX:=$HOME}/.ghcup/env" ] && source "${GHCUP_INSTALL_BASE_PREFIX:=$HOME}/.ghcup/env"

# OPTIONS 
setopt HIST_SAVE_NO_DUPS	# Do not write duplicate events to history

# PROMPT 
PS1='%T %B%F{grey}μ%f%b ' 

# VIM EMULATION 
bindkey -v 
export KEYTIMEOUT=1 	# Quicker switch between modes
cursor_mode() {
    cursor_block='\e[2 q'
    cursor_beam='\e[3 q'

    function zle-keymap-select {
        if [[ ${KEYMAP} == vicmd ]] ||
            [[ $1 = 'block' ]]; then
            echo -ne $cursor_block
        elif [[ ${KEYMAP} == main ]] ||
            [[ ${KEYMAP} == viins ]] ||
            [[ ${KEYMAP} = '' ]] ||
            [[ $1 = 'beam' ]]; then
            echo -ne $cursor_beam
        fi
    }

    zle-line-init() {
        echo -ne $cursor_beam
    }

    zle -N zle-keymap-select
    zle -N zle-line-init
}; cursor_mode		# Cursor shape based on Vim mode 

clear	# On startup

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

