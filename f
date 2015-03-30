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

my @files;
my @grep;

while (my $arg = pop @ARGV){
    if (-d $arg || -e $arg){
        push @files, $arg;
    } else {
        push @grep, $arg;
    }
}
my $files = join(' ', @files);
if (!$files){
    $files = '*';
}
my $grep = join(' ', reverse @grep);

my $cmd = "grep \"$grep\" -r --color=always -n -C3 $files | less -R";
#print "$cmd\n";
system($cmd);

