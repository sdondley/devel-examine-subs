#!perl -T

use Test::More tests => 11;

BEGIN {#1
    use_ok( 'Devel::Examine::Subs' ) || print "Bail out!\n";
}
{#2
    my $des = Devel::Examine::Subs->new();
    my $res = $des->line_numbers({ file => 't/sample.data', get => 'obj' });
    is ( ref($res), 'ARRAY', "sublist() properly returns an aref" );
}
{#3
    my $des = Devel::Examine::Subs->new();
    my $res = $des->line_numbers({ file => 't/sample.data', get => 'obj' });
    is ( ref($res->[0]), 
            'Devel::Examine::Subs::Sub', 
            "elements of sublist() return are proper objects "
    );
}
{#4-7
    my $des = Devel::Examine::Subs->new();
    my $res = $des->line_numbers({ file => 't/sample.data', get => 'object' });
    for (qw(name start stop count)){
        can_ok( $res->[0], $_ );
    }
}
{#8
    my $des = Devel::Examine::Subs->new();
    my $res = $des->sublist({ file => 't/sample.data' });
    ok ( $res->[0]->start() =~ /^\d+$/, "sublist() object calling start() returns an int " );
}
{#9
    my $des = Devel::Examine::Subs->new();
    my $res = $des->sublist({ file => 't/sample.data' });
    ok ( $res->[0]->stop() =~ /^\d+$/, "sublist() object calling stop() returns an int " );
}
{#10
    my $des = Devel::Examine::Subs->new();
    my $res = $des->sublist({ file => 't/sample.data' });
    ok ( $res->[0]->count() =~ /^\d+$/, "sublist() object calling count() returns an int " );
}
{#11
    my $des = Devel::Examine::Subs->new();
    my $res = $des->sublist({ file => 't/sample.data' });
    ok ( $res->[0]->name() =~ /^[\d\w]+$/, "subdata() object calling name() returns a safe string " );
}

my $des = Devel::Examine::Subs->new();