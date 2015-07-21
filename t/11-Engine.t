#!perl -T
use warnings;
use strict;

use Test::More tests => 7;

use Data::Dumper;

BEGIN {#1-2
    use_ok( 'Devel::Examine::Subs' ) || print "Bail out!\n";
    use_ok( 'Devel::Examine::Subs::Engine' ) || print "Bail out!\n";
}

# engine config
my $namespace = "Devel::Examine::Subs";
my $engine_module = $namespace . "::Engine";
my $compiler = $engine_module->new();
my $engine = $compiler->{engines}{_test}->();

{#3
    ok ( ref($engine) eq 'CODE', "a returned \$engine is a CODE ref" );
}
{#4
    my $res = $engine->();
    is ( ref($res), 'HASH', "_test engine returns a hashref" );
}
{#5
    my $res = $engine->();
    is ( ref($res), 'HASH', "_test engine returns a hashref properly" );
}
{#6
    my $des = _des({engine => '_test'});
    my $engine = $des->_engine();
    is ( ref($engine), 'CODE', "_load_engine() returns a cref properly" );
    is ( ref($engine->()), 'HASH', "the _test engine returns a hashref" );
}
sub _engine { 
    my $p = shift; 
    return \&{$compiler->{engines}{$p}}; 
};

sub _des {  
    my $p = shift; 
    my $des =  Devel::Examine::Subs->new({engine => $p->{engine}}); 
    return $des;
};