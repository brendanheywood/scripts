#!/usr/bin/perl

use strict;

sub usage {

    print <<EOF;

v somefile

v somefile:123 <- line number (eg from diff / grep)

EOF
    exit;
}

if ($#ARGV eq -1){
    usage();
}

my $file = shift @ARGV;
my $line = '';
if ($file =~ /(.*):(\d+).*/){
    $file = $1;
    $line = "+$2";
}
my $cmd = "vim $line $file";
#print "$cmd\n";
system($cmd);

