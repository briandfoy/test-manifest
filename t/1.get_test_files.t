# $Id$
use strict;

use Test::More tests => 9;

use Test::Manifest qw(get_t_files manifest_name);
use Test::Data qw(Scalar);

my $test_manifest = manifest_name();

my @tests = ();

print "bail out! Could not open manifest!"
	unless open my $in, $test_manifest;

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

undef_ok( $string );

my @array = get_t_files();

undef_ok( $string );
}
