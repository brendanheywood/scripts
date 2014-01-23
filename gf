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
my $RESET = color('reset');

my $cmd = "git -c color.ui=always log -p -S'$grep' --full-diff -- . | sed -e 's/$grep/$BLINK\&$RESET/' | less -R ";
print "$cmd\n";
system($cmd);

