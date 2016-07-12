#!/usr/bin/perl

# This is so I can ring a phone directly from a webpage that uses the tel: scheme
#
# This works by chrome handing off tel: to xdg-open (usually on by default)
#
# xdg-open then handles tel by calling this script.
#
# See what it is currently set to:
# xdg-mime query default x-scheme-handler/tel
#
#
#
use strict;

my $num = $ARGV[0];

$num =~ s/tel://g;
$num =~ s/\s//g;
$num =~ s/^\+61/0/g;

# `linphone-3 --call $num`;
`jitsi sip:$num`;
