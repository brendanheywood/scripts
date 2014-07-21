#!/usr/bin/perl

use strict;

my $num = $ARGV[0];

$num =~ s/tel://g;
$num =~ s/\s//g;
$num =~ s/^\+61/0/g;

# `linphone-3 --call $num`;
`jitsi sip:$num`;
