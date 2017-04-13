#!/usr/bin/perl

use strict;
use Term::ReadKey;

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

my $cmd = "grep";
$cmd .= " --color=always";
$cmd .= " -r";  # recursive
$cmd .= " -n";  # show line numbers
$cmd .= " -F";  # = fixed string (ie not regex)
$cmd .= " -C9"; # 3 lines of context
$cmd .= " -- "; # We do this with -- mode so we can search for > < - etc
$cmd .= " '$grep'";
$cmd .= " $files";
$cmd .= " | cut -c1-250"; # Just ignore matches in compiled css etc
$cmd .= " | less -R"; # -R = retain control chars (ie colors)

# print "$cmd\n";
system($cmd);

