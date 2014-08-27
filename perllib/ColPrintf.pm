package ColPrintf;

use strict;
use Exporter;
use vars qw($VERSION @ISA @EXPORT @EXPORT_OK %EXPORT_TAGS);

$VERSION     = 1.00;
@ISA         = qw(Exporter);
@EXPORT      = qw(col_printf);
@EXPORT_OK   = qw(col_printf);
%EXPORT_TAGS = ( DEFAULT => [qw(&col_printf)] );

use Data::Dumper;
use Text::Wrap;

# like printf but each string bit can wrap

# http://search.cpan.org/~muir/Text-Tabs%2BWrap-2013.0523/lib.old/Text/Wrap.pm

# first parse the string ino chunks
# then find the width of each chunk
# print that into a string buffer using the wrap library

# now find the buffer with the most lines
# then re-stritch of the buffers together using printf again but with chunk from each buffer

# do some magic with things which are not %s and also test with strings that don't wrap
# as they don't have whitespace

sub col_printf {

    my @in = @_;

#    print "cols: ".join("[]", @in);
#    print "\n\n\n";
    my @cols = ($in[0] =~ /\%-?\d*s/g);

    my @out;

    my $c = 0;
    my $maxlines = 0;
    foreach my $col (@cols){
        $c++;
        $col =~ m/(\d+)/;
        my $width = $1;
#        print "W = $width\n";
        $Text::Wrap::columns=$width;
        my $lines = wrap('','',$in[$c]);
        my @lines = split /\n/, $lines;
        if ($#lines +1 > $maxlines){
            $maxlines = $#lines + 1;
        }
        # $out[$c] = $wrap;
        $out[$c-1] = ();
        for(my $row=0; $row<=$#lines; $row++){
            $out[$c-1][$row] = $lines[$row];
        }
#        print "T = \n 123456789 123456789 123456789\n";
#        print join "\n", @lines;
#        print "===\n";
    }
#    print "\nMAX = $maxlines \n";

#    print join '------', @cols;

#    print Dumper(@out);

#    print "-------\n\n\n";

    my $str = '';
    for(my $row=0; $row<$maxlines; $row++){

#        print "Row $row\n";
#        $str .= $in[0];

        my @data;

        for(my $c=0; $c<=$#cols; $c++){
            $data[$c] = $out[$c][$row];
#            print "col $c = ";
#            print $data[$c];
#            print "\n";
        }

#        print "data: ". join "++", @data;
#        print ">>>\n";
        my $tmp = sprintf($in[0], @data);
        $str .= $tmp;
    }

    print $str;
}


1;
