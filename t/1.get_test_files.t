# $Id$
use strict;

use Test::More tests => 7;

use Test::Manifest qw(get_t_files manifest_name);

my $test_manifest = manifest_name();

open IN, 'test_manifest' or 
	print "bail out! Could not open test_manifest\n$!\n";

open OUT, "> $test_manifest" or 
	print "bail out! Could not open $test_manifest\n$!\n";

while( <IN> ) { print OUT }
close IN;
close OUT;

my @tests = ();

print "bail out! Could not open manifest!"
	unless open( my $in, $test_manifest );

while( <$in> )
	{
	chomp;
	push @tests, $_;
	}

my $expected = join " ", map { "t/$_" } @tests;

my $string = get_t_files();

is( $string, $expected );

my @array = get_t_files();

foreach my $i ( 0 .. $#array )
	{
	is( $array[$i], "t/$tests[$i]" );
	}

{
local $SIG{__WARN__} = sub { 1 };

( unlink $test_manifest ) ? pass() : fail();

my $string = get_t_files();

ok( ! $string );

my @array = get_t_files();

ok( ! $string );
}
