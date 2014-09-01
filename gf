#!/usr/bin/perl

use strict;
use Term::ANSIColor;

sub usage {

    print <<EOF;

gf something

EOF
    exit;
}

if ($#ARGV eq -1){
    usage();
}

my $grep = shift @ARGV;
my $files = '*';
if ($#ARGV ne -1){
    $files = shift @ARGV;
}

my $BLINK = color('reverse');
my $RESET = color('reset'); # known bug: it resets the color when we only want to reset the inversion

my $cmd = "git log --color -p -S'$grep' --full-diff -- . | sed -e 's/$grep/$BLINK\&$RESET/' | less";
# --color  - force color output, normally turned off when we pipe
#  -p      - generate pathc
#  -S      - look for where this string was added or removed
# --full-diff
# --       - show only commits that matter
#

#print "$cmd\n";
system($cmd);

