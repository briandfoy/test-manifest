# $Id$
use strict;

use Test::More tests => 9;

use Test::Manifest qw(get_t_files manifest_name);

my $test_manifest = manifest_name();

open IN, 'test_manifest' or 
	print "bail out! Could not open test_manifest\n$!\n";

open OUT, "> $test_manifest" or 
	print "bail out! Could not open $test_manifest\n$!\n";

while( <IN> ) { print OUT }
close IN;
close OUT;


# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
my $expected = "t/0.load.t t/1.get_test_files.t t/1.make_test_manifest.t ".
	"t/leading_space.t t/trailing_space.t";

my @tests = split /\s+/, $expected;

my $string = get_t_files();

is( $string, $expected, "Single string version of tests is right" );

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
my @array = get_t_files();

foreach my $i ( 0 .. $#array )
	{
	is( $array[$i], $tests[$i], "Test file $i has expected name" );
	}

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
{
local $SIG{__WARN__} = sub { 1 };

( unlink $test_manifest ) ? 
	pass( "test_manifest unlinked") : 
	fail( "test_manifest still around after unlink!");

my $string = get_t_files();

ok( ! $string, "Nothing returned when test_manifest does not exist (scalar)" );

my @array = get_t_files();

ok( ! $string, "Nothing returned when test_manifest does not exist (list)" );
}
