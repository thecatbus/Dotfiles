# OPTIONS 
setopt HIST_SAVE_NO_DUPS	# Do not write duplicate events to history

# PROMPT 
PS1='%F{blue}%T %b%f ' 

# ALIASES
vim() {
    if ("$1"==""); then mvim else mvim "$1" --remote-silent fi
}

emacs() {
    emacsclient --reuse-frame --alternate-editor="" "$1" &
}

# ZSH Vi Mode
source /usr/local/opt/zsh-vi-mode/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh
ZVM_INSERT_MODE_CURSOR=$ZVM_CURSOR_BLINKING_UNDERLINE
ZVM_NORMAL_MODE_CURSOR=$ZVM_CURSOR_BLINKING_BLOCK
ZVM_VISUAL_MODE_CURSOR=$ZVM_CURSOR_BLINKING_BLOCK
ZVM_OPPEND_MODE_CURSOR=$ZVM_CURSOR_BLINKING_UNDERLINE

ZVM_LINE_INIT_MODE=$ZVM_MODE_NORMAL

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

# PATH
export PATH="$PATH:/usr/local/etc/rubber/bin:/usr/local/anaconda3/bin"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/usr/local/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/usr/local/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/usr/local/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/usr/local/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
