#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export SSH_AUTH_SOCK=$XDG_RUNTIME_DIR/ssh-agent.socket

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='\[\e[40;37m\]\w:\[\e[m\] '

# aliases
alias r='sudo /sbin/reboot'
alias sd='sudo /sbin/shutdown now'
alias t='date +%H:%M'
alias d='date +%Y-%m-%d'
alias b='cat /sys/class/power_supply/BAT1/capacity'
alias bs='cat /sys/class/power_supply/BAT1/status'
alias br='chromium'
alias ex='libreoffice'

alias i='sudo pacman -S'

vs() {
    if [ "$#" -eq 0 ]; then
        code .
    else
        code $1
    fi
}

# git aliases
alias cl='git clone'
alias s='git status'

c() {
    git add .
    if [ "$#" -eq 0 ]; then
        EDITOR=vim git commit
    else
        git commit -m "$1"
    fi
}

alias pl='git pull origin'

alias br='git branch'
crbr() {
    git switch -c $1
}
chbr() {
    git switch $1
}

alias l='git log'
alias p='git push origin'
alias rs='git reset HEAD~1 --soft'
# git aliases

alias m='make'
# aliases

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - bash)"
