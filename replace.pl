#!/usr/bin/perl
# This does a search and replace in multiple files

if ($#ARGV le 1){
  print STDERR <<EOF;
  Usage: $0 search replace file_list
EOF
  exit;
}

$search = $ARGV[0];
$replace = $ARGV[1];
@files = @ARGV[2..$#ARGV];

foreach $file (@files){
  if (!open (FILE, $file)){
    print STDERR "Can't open $file for read\n";
    next;
  }
  @lines = <FILE>;
  close FILE;
  if (!open (FILE, ">$file")){
    print STDERR "Can't open $file for write\n";
    next;
  }
  $total = 0;
  foreach $line (@lines){
    $c = ($line =~ s/$search/$replace/gi);
    print FILE $line;
    $total += $c;
  }
  close FILE;
  print "Replaced $total in $file\n";
}

