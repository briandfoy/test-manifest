#!perl
use strict;
use warnings;

use Module::Build;

my $class = 'Module::Build';

my $build = $class->new(
	module_name       => 'Test::Manifest',
	dist_abstract     => 'Interact with a t/test_manifest file',
	dist_version_from => 'lib/Test/Manifest.pm',
	license           => 'perl',
	dist_author       => 'brian d foy <bdfoy@cpan.org>',

	build_requires => {
		'Test::More'             => '0',
		},

	requires       => {
		'perl'                   => '5.008',
		},

	add_to_cleanup  => [ qw|Test-* t/test_manifest| ],

	meta_merge => {
		resources => {
			bugtracker   => 'http://rt.cpan.org/NoAuth/Bugs.html?Dist=Test-Manifest',
			repository   => 'http://github.com/briandfoy/test-manifest',
			#cheezburgers => 'http://icanhascheezburger.com/',
			},
		},
	);

$build->create_build_script;
