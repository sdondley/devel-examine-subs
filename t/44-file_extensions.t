#!perl 
use warnings;
use strict;

use Data::Dumper;
use Test::More tests => 6;

use_ok( 'File::Edit::Portable' ) || print "Bail out!\n";

{
    my $rw = File::Edit::Portable->new;

    my $dir = 't';

    my @files = $rw->dir(
                    dir => $dir,
                    list => 1,
                );

    ok (@files >= 67, "with default extensions, the correct num of files is returned");

    @files = $rw->dir(
                    dir => $dir,
                    list => 1,
                    maxdepth => 1,
                );

    ok (@files >= 50 && @files <= 60, "things appear reasonable with maxdepth param set");

    @files = $rw->dir(
                dir => $dir,
                list => 1,
                types => [qw(*.t)],
            );

    is (@files, 49, "using *.t extension works properly");

    @files = $rw->dir(
                dir => $dir,
                list => 1,
                types => [qw(*.data)],
            );

    is (@files, 8, "using *.data extension works properly");

    @files = $rw->dir(
                dir => $dir,
                list => 1,
                types => [qw(*.data *.t)],
            );

    is (@files, 57, "using *.data and *.t extensions works properly");

}

