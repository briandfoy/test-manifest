# $Id$
package Test::Manifest;
use strict;

use base qw(Exporter);
use vars qw(@EXPORT_OK @EXPORT $VERSION);

use Carp qw(carp);
use File::Spec::Functions qw(catfile);
use Exporter;

@EXPORT    = qw(run_t_manifest);
@EXPORT_OK = qw(get_t_files make_test_manifest manifest_name);

$VERSION = sprintf "%d.%02d", q$Revision$ =~ m/ (\d+) \. (\d+) /x;

my $Manifest = catfile( "t", "test_manifest" );

require 5.006;

use ExtUtils::MM_Any;

{
local $^W = 0;

* ExtUtils::MM_Any::test_via_harness = sub
	{
	my($self, $perl, $tests) = @_;

	return qq|\t$perl "-MTest::Manifest" | .
		   qq|"-e" "run_t_manifest(\$(TEST_VERBOSE), '\$(INST_LIB)', | .
		   qq|'\$(INST_ARCHLIB)')"\n|;
	}
}

=head1 NAME

Test::Manifest - interact with a t/test_manifest file

=head1 SYNOPSIS

	# in Makefile.PL
	eval "use Test::Manifest";

	# in the file t/test_manifest, list the tests you want 
	# to run
	
=head1 DESCRIPTION

Test::Harness assumes that you want to run all of the .t files
in the t/ directory in ascii-betical order during C<make test>
unless you say otherwise.  This leads to some interesting
naming schemes for test files to get them in the desired order.
This interesting names ossify when they get into source control,
and get even more interesting as more tests show up.

Test::Manifest overrides the default behaviour by replacing the
test_via_harness target in the Makefile.  Instead of running at the
t/*.t files in ascii-betical order, it looks in the t/test_manifest file
to find out which tests you want to run and the order in which you want
to run them.  It constructs the right value for MakeMaker to do the
right thing.

In t/test_manifest, simply list the tests that you want to run.  Their
order in the file is the order in which they run.  You can comment
lines with a #, just like in Perl, and Test::Manifest will strip
leading and trailing whitespace from each line.  It also checks that
the specified file is actually in the t/ directory.  If the file
does not exist, it does not put its name in the list of test
files to run.

=head2 Functions

=over 4

=item run_t_manifest()

Run all of the files in t/test_manifest through Test::Harness:runtests
in the order they appear in the file.

If you want to use this, in Makefile.PL you need to override some
MakeMaker magic (after you load ExtUtils::MakeMaker).  I recommend
putting something like this directly in Makefile.PL so it does not
depend on anything else.  A Makefile.PL with dependencies is a big
headache.

	eval "use Test::Manifest";

	unless( $@ )
		{
		* ExtUtils::MM_Any::test_via_harness = sub
			{
			my($self, $perl, $tests) = @_;

			return qq|\t$perl "-MTest::Manifest" | .
				   qq|"-e" "run_t_manifest(\$(TEST_VERBOSE), '\$(INST_LIB)', | .
				   qq|'\$(INST_ARCHLIB)')"\n|;
			}
		}

=cut

sub run_t_manifest
	{
	require Test::Harness;
	require File::Spec;

	$Test::Harness::verbose = shift;

	local @INC = @INC;
	unshift @INC, map { File::Spec->rel2abs($_) } @_;

	my @files = get_t_files();
	print STDERR "Test::Manifest::test_harness found [@files]\n";

	Test::Harness::runtests( @files );
	}

=item get_t_files()

In scalar context it returns a single string that you can use directly
in WriteMakefile().

In list context it returns a list of the files it found in
t/test_manifest.

If a t/test_manifest file does not exist, get_t_files() returns
nothing.

get_t_files() warns you if it can't find t/test_manifest, or if
entries start with "t/".

=cut

sub get_t_files()
	{
	carp( "$Manifest does not exist!" ) unless -e $Manifest;
	return unless open my( $fh ), $Manifest;

	my @tests = ();

	while( <$fh> )
		{
		chomp;
		s/^\s+|\s+$//g;
		next if m/^#/;
		carp( "test file begins with t/ [$_]" ) if m|^t/|;
		push @tests, catfile( "t", $_ ) if -e catfile( "t", $_ );
		}
	close $fh;

	return wantarray ? @tests : join " ", @tests;
	}

=item make_test_manifest()

Creates the test_manifest file in the t directory by reading
the contents of the t directory.

TO DO: specify tests in argument lists.

TO DO: specify files to skip.

=cut

sub make_test_manifest()
	{
	carp( "t/ directory does not exist!" ) unless -d "t";
	return unless open my( $fh ), "> $Manifest";

	my $count = 0;
	while( my $file = glob("t/*.t") )
		{
		$file =~ s|^t/||;
		print $fh "$file\n";
		$count++;
		}
	close $fh;

	return $count;
	}

=item manifest_name()

Returns the name of the test manifest file, relative to t/

=cut

sub manifest_name
	{
	return $Manifest;
	}

=back

=head1 SOURCE AVAILABILITY

This source is part of a SourceForge project which always has the
latest sources in CVS, as well as all of the previous releases.

	http://sourceforge.net/projects/brian-d-foy/

If, for some reason, I disappear from the world, one of the other
members of the project can shepherd this module appropriately.

=head1 AUTHOR

brian d foy, C<< <bdfoy@cpan.org> >>

=head1 COPYRIGHT

Copyright 2002-2004, brian d foy, All Rights Reserved

You may use and distribute this module under the same terms
as Perl itself

=cut

1;
