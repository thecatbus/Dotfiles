# OPTIONS 
setopt HIST_SAVE_NO_DUPS	# Do not write duplicate events to history

# PROMPT 
PS1='%F{blue}%T μ%b%f ' 

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

# FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='ag --hidden -g ""'
export FZF_CTRL_T_COMMAND='ag --hidden -g ""'
export FZF_DEFAULT_OPTS='--info=hidden
                         --height 30% 
                         --layout=reverse 
                         --multi               
                         --cycle
                         --color=gutter:-1,bg+:-1,fg:-1:dim,fg+:-1:bold'

# DDGR
export DDGR_COLORS='eMecxy'
export DISABLE_PROMPT_COLOR=1 
alias duck="ddgr --num=5 --reg='uk-en' --unsafe"
