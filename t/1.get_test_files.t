# $Id$
use strict;

use Test::More tests => 13;

use File::Copy qw(copy);
use File::Spec;

use Test::Manifest qw(get_t_files manifest_name);

copy( 'test_manifest', manifest_name() );

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
my $expected = join " ", map { File::Spec->catfile( "t", $_ ) } qw(
		0.load.t 1.get_test_files.t 1.make_test_manifest.t
		leading_space.t trailing_space.t
		);

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

( unlink manifest_name() ) ? 
	pass( "test_manifest unlinked") : 
	fail( "test_manifest still around after unlink!");

my $string = get_t_files();

ok( ! $string, "Nothing returned when test_manifest does not exist (scalar)" );

my @array = get_t_files();

ok( ! $string, "Nothing returned when test_manifest does not exist (list)" );
}

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
{
local $Test::Harness::verbose = 1;
copy( 'test_manifest_levels', manifest_name() );

my @expected = ( [] );
$expected[1] = [ qw( 0.load.t 1.get_test_files.t pod_coverage.t) ];
$expected[2] = [ qw( 0.load.t 1.get_test_files.t 1.make_test_manifest.t 
	pod_coverage.t ) ];
$expected[3] = [ qw( 0.load.t 1.get_test_files.t 1.make_test_manifest.t 
	leading_space.t pod_coverage.t trailing_space.t ) ];
$expected[0] = [ qw( 0.load.t 1.get_test_files.t 1.make_test_manifest.t 
	leading_space.t pod_coverage.t trailing_space.t 99.pod.t ) ];
	
foreach my $level ( 0 .. 3 )
	{
	my $string = get_t_files( $level );
	my $expected = join ' ', map { File::Spec->catfile( 't', $_ ) } 
		@{ $expected[$level] };
	is( $string, $expected, "Level $level version of tests is right" );
	}

}

__END__
# this is a comment, then a blank line

0.load.t
1.get_test_files.t 1 
1.make_test_manifest.t 2
leading_space.t 2.9
pod_coverage.t 1 # with a comment
trailing_space.t 3 # with a comment
99.pod.t	3.1  
