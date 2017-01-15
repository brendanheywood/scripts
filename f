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

my $cmd = "grep '$grep'";
$cmd .= " -r";  # recursive
$cmd .= " -n";  # show line numbers
$cmd .= " -F";  # = fixed string (ie not regex)
$cmd .= " -C3"; # 3 lines of context
$cmd .= " --color=always"; #
$cmd .= " $files"; #3
$cmd .= " | less -R"; # -R = retain control chars (ie colors)

# my $cmd = "grep \"$grep\" -r -n -C3 $files | f-opener \"$grep\" ";



print "$cmd\n";
system($cmd);

