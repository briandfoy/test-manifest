#!perl
use strict;
use warnings;

use Module::Build;

my $class = do {
	if( eval "use Test::Manifest 2.00; 1" ) {
		Test::Manifest->get_module_build_subclass;
		}
	else {
		'Module::Build';
		}
	};
	
my $build = $class->new(
	module_name       => 'Test::More',
	dist_abstract     => 'Interact with a t/test_manifest file',
	dist_version_from => 'lib/Manifest.pm',
	license           => 'perl',
	dist_author       => 'brian d foy <bdfoy@cpan.org>',

	recommends => {
		'Test::Manifest'         => '1.23',
		},
		
	build_requires => {
		'Test::More'             => '0',
		},
		
	requires       => {
		'perl'                   => '5.008',
		},

	pm_files        => {
		'lib/Manifest.pm' => 'lib/Test/Manifest.pm',
		},

	add_to_cleanup  => [ qw|Test-* t/test_manifest| ], 
	);

$build->create_build_script;
