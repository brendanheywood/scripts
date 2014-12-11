
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



# This is pure gold!
# Add your 'projects' or whatever folder to CDPATH enables you to 'cd <tab-autocomplete>' to it from anywhere
export CDPATH=".:/var/www/"

