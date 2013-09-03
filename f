#!/usr/bin/perl

use strict;

sub usage {

    print <<EOF;

f something

f something files

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
my $cmd = "grep \"$grep\" -r --color=always -n -C3 $files | less -R";
#print "$cmd\n";
system($cmd);

