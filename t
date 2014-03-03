#!/usr/bin/perl

use strict;

my $cmd = "tail -f /var/log/sitelogs/*/*error* | sed 's/\\\\n/\\n/g' ";
#print "$cmd\n";
system($cmd);

