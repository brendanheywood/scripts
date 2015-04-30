
alias gt=git
alias gut=git
alias got=git

#
#PS1='${debian_chroot:+($debian_chroot)}'

PS1=''

# user@host in green
# PS1="$PS1\[\033[01;32m\]"
# user@host
PS1="$PS1\u@\h"
# turn off green
# PS1="$PS1\[\033[00m\]"

# 10:42:15 time with seconds
PS1="$PS1 \T "

# pale blue
PS1="$PS1\[\033[01;34m\]"
# cwd
PS1="$PS1\w"
# color reset
PS1="$PS1\[\033[00m\] "

# $ prompt
PS1="$PS1\$ "


alias l='ls -CFa'

alias o='xdg-open'

alias grep='grep --color=auto'

export PATH="$PATH:/home/brendan/scripts/"
export PATH="$PATH:/home/brendan/moosh/bin"
eval "$(/home/brendan/moosh/bin/moosh init -)"

export DEBFULLNAME='Brendan Heywood'
export DEBEMAIL='brendan@catalyst.net.nz'

# This add magic, like cd'ing to a remote dir on login :)
alias ssh='~/scripts/ssh'

# I always seem to type this!
alias cd..='cd ..'

export LESS="-riMSx4 -FX --shift .1"
# -r  show raw control chars (so colors work)
# -i  ignore case
# -M  verbose prompt
# -S  chop long lines
# -x4 tabs stop at 4
# -F  quit if one screen
# -X  disable screen clear
# --shift .1 left and right move 10% of screen
#

# If a command you run returns a fail, it isn't available when you press 'up' which is real pain
# in the arse when you are re-running things consstantly that fail, like a uni test. This fixes
# that so all commands go into the history
HISTCONTROL=ignoreboth

# This is pure gold! (actually I thought it was, but it turns out to fairly impractical and I keep on
# accidentally cd'ing to some random place, or worse I tab auto complete when I know there is a single
# directory, and it doesn't autocomplete because it's searching other directories. So I've commented out
# but left in as a cautionary tale:
# Add your 'projects' or whatever folder to CDPATH enables you to 'cd <tab-autocomplete>' to it from anywhere
#   export CDPATH=".:/var/www/"
export CDPATH="."

