# $Id$
use ExtUtils::MakeMaker;

WriteMakefile
        (
        'NAME'          => 'Test::Manifest',
        'VERSION_FROM'  => 'lib/Manifest.pm',
        
		'PREREQ_PM' => {
			'Test::More'       => '0',
			},
			
        'PM'       => 
        	{
            'lib/Manifest.pm'  => '$(INST_LIBDIR)/Manifest.pm',
            },
            
        clean => { FILES => 'Test-Manifest-* t/test_manifest' },
        );
