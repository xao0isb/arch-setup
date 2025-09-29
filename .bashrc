#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='\[\e[40;37m\]\w:\[\e[m\] '

alias r='sudo /sbin/reboot'
alias s='sudo /sbin/shutdown now'
alias t='date +%H:%M'
alias d='date +%Y-%m-%d'
alias b='cat /sys/class/power_supply/BAT1/capacity'
alias bs='cat /sys/class/power_supply/BAT1/status'
alias br='chromium'
