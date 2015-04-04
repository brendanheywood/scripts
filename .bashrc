
alias gt=git
alias gut=git
alias got=git


alias l='ls -CFa'

alias o='xdg-open'

alias grep='grep --color=auto'

export PATH="$PATH:/home/brendan/scripts/"
export PATH="$PATH:/home/brendan/moosh/bin"
eval "$(/home/brendan/moosh/bin/moosh init -)"

export DEBFULLNAME='Brendan Heywood'
export DEBEMAIL='brendan@catalyst.net.nz'


alias ssh='~/scripts/ssh'

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

