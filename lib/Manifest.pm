package Test::Manifest;
use strict;

use base qw(Exporter);
use vars qw(@EXPORT_OK);

use Carp qw(carp);
use Exporter;

@EXPORT_OK = qw(get_t_files make_test_manifest);

my $Manifest = "t/test_manifest";

=head1 NAME

Test::Manifest - interact with a t/test_manifest file

=head1 SYNOPSIS

use Test::Manifest qw(get_t_files);

WriteMakefile( ..., test => { TESTS => get_t_files() } );

=head1 DESCRIPTION

MakeMaker assumes that you want to run all of the .t files
in the t/ directory in ascii-betical order during C<make test>
unless you say otherwise.  This leads to some interesting 
naming schemes for test files to get them in the desired order.

You can specify any order or any files that you like, though,
with the C<test> directive to WriteMakefile.

Test::Manifest looks in the t/test_manifest file to find out
which tests you want to run and the order in which you want
to run them.  It constructs the right value for MakeMaker to
do the right thing.

=head1 FUNCTIONS

=over 4

=item get_t_files()

In scalar context it returns a single string that you can use directly
in WriteMakefile().

In list context it returns a list of the files it found in
t/test_manifest.

If a t/test_manifest file does not exist, get_t_files() returns
"t/*.t", which is the default.

get_t_files() warns you if it can't find t/test_manifest, or if
entries start with "t/".

=cut

sub get_t_files()
	{
	carp( "t/test_manifest does not exist!" ) unless -e $Manifest;
	return "t/*.t" unless open my $fh, $Manifest;
	
	my @tests = ();
	
	while( <$fh> )
		{
		chomp;
		carp( "test file begins with t/ [$_]" ) if m|^t/|;
		push @tests, "t/$_" if -e "t/$_";
		}
		
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
	return unless open my $fh, "> $Manifest";
	
	my $count = 0;
	while( my $file = glob("t/*.t") )
		{
		$file =~ s|^t/||;
		print $fh "$file\n";
		$count++;
		}
	
	return $count;
	}

=back
	
=head1 AUTHOR

brian d foy, E<lt>bdfoy@cpan.orgE<lt>

=head1 COPYRIGHT

Copyright 2002, brian d foy, All Rights Reserved

You may use and distribute this module under the same terms
as Perl itself

=cut
	
1;
