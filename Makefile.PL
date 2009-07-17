use ExtUtils::MakeMaker;

require 5.006;

WriteMakefile
	(
	'NAME'          => 'Test::Manifest',
	'ABSTRACT'      => 'interact with a t/test_manifest file',
	'VERSION_FROM'  => 'lib/Manifest.pm',
	'LICENSE'       => 'perl',
	'AUTHOR'        => 'brian d foy <bdfoy@cpan.org>',
	
	'PREREQ_PM' => {
		'Test::More'          => '0',
		'ExtUtils::MakeMaker' => '6.03',
		},
		
	'PM'       => 
		{
		'lib/Manifest.pm'  => '$(INST_LIBDIR)/Manifest.pm',
		},
	  
	'MAN3PODS' => {},
		
	clean => { FILES => 'Test-Manifest-* t/test_manifest' },
	);
