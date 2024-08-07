# OPTIONS
setopt HIST_SAVE_NO_DUPS	# Do not write duplicate events to history
export EDITOR="vim"

# COMPLETIONS
autoload -U compinit; compinit
_comp_options+=(globdots)

# PROMPT
PS1='%F{blue}%T %b%f '

# ALIASES
vim() {
    if [[ -z "$1" ]]
    then
        mvim
    else
        mvim --remote-silent "$1"
    fi
}

emacs() {
    emacsclient --quiet --suppress-output --reuse-frame --alternate-editor="" $1 &
}

tex-project() {
    curl -L -O https://github.com/thecatbus/tex-template/archive/main.zip
    unzip main.zip && rm main.zip

    if [[ ! -z "$1" ]]
    then
        mv tex-template-main "$1" && cd "$1"
    else
        cd tex-template-main
    fi

    git init
}

# ZSH Vi Mode
source /usr/local/opt/zsh-vi-mode/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh
ZVM_INSERT_MODE_CURSOR=$ZVM_CURSOR_BLINKING_UNDERLINE
ZVM_NORMAL_MODE_CURSOR=$ZVM_CURSOR_BLINKING_BLOCK
ZVM_VISUAL_MODE_CURSOR=$ZVM_CURSOR_BLINKING_BLOCK
ZVM_OPPEND_MODE_CURSOR=$ZVM_CURSOR_BLINKING_UNDERLINE

ZVM_LINE_INIT_MODE=$ZVM_MODE_NORMAL

# FZF
#[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
#export FZF_DEFAULT_COMMAND='ag --hidden -g ""'
#export FZF_CTRL_T_COMMAND='ag --hidden -g ""'
#export FZF_DEFAULT_OPTS='--info=hidden
#                         --height 30%
#                         --layout=reverse
#                         --multi
#                         --cycle
#                         --color=gutter:-1,bg+:-1,fg:-1:dim,fg+:-1:bold'

# DDGR
# export DDGR_COLORS='eMecxy'
# export DISABLE_PROMPT_COLOR=1
# alias duck="ddgr --num=5 --reg='uk-en' --unsafe"

# PATH
export PATH="$PATH:/usr/local/etc/rubber/bin:/usr/local/anaconda3/bin:/Users/parth/Notebook/.scripts:/Users/parth/Library/gap-4.12.2/bin"

export INFOPATH="/Library/TeX/Documentation/texmf-dist-doc/info:$INFOPATH"

# HEBIKANI
export WANIKANI_API_KEY="83e787c3-fc54-46c2-b004-86c60a41edca"

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
