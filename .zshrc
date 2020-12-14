export PATH="$PATH:/Users/parth/.local/bin"
[ -f "${GHCUP_INSTALL_BASE_PREFIX:=$HOME}/.ghcup/env" ] && source "${GHCUP_INSTALL_BASE_PREFIX:=$HOME}/.ghcup/env"

# OPTIONS 
setopt HIST_SAVE_NO_DUPS	# Do not write duplicate events to history

# PROMPT 
PS1='%F{blue}%T %Bμ%b%f ' 

# VIM EMULATION 
bindkey -v 
export KEYTIMEOUT=1 	# Quicker switch between modes
clear 			# On startup

# CURSOR SHAPE DEPENDING ON VI MODE 
function _set_cursor() {
    if [[ $TMUX = '' ]]; then
      echo -ne $1
    else
      echo -ne "\ePtmux;\e\e$1\e\\"
    fi
}

# Remove mode switching delay.
KEYTIMEOUT=5

function _set_block_cursor() { _set_cursor '\e[1 q' }
function _set_beam_cursor() { _set_cursor '\e[3 q' }

function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] || [[ $1 = 'block' ]]; then
      _set_block_cursor
  else
      _set_beam_cursor
  fi
}
zle -N zle-keymap-select
# ensure beam cursor when starting new terminal
precmd_functions+=(_set_beam_cursor) 
# ensure insert mode and beam cursor when exiting vim
zle-line-init() { zle -K viins; _set_beam_cursor }
zle-line-finish() { _set_block_cursor }
zle -N zle-line-finish

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"


