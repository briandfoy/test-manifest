# $Id$
use ExtUtils::MakeMaker;

require 5.006;

WriteMakefile
        (
        'NAME'          => 'Test::Manifest',
        'VERSION_FROM'  => 'lib/Manifest.pm',
        
		'PREREQ_PM' => {
			'Test::More'          => '0',
			'ExtUtils::MakeMaker' => '6.03',
			},
			
        'PM'       => 
        	{
            'lib/Manifest.pm'  => '$(INST_LIBDIR)/Manifest.pm',
            },
          
        'MAN3PODS' =>
        	{
        	'lib/Manifest.pm' => '$(INST_MAN3DIR)/Test::Manifest.3',
        	},
        	
        clean => { FILES => 'Test-Manifest-* t/test_manifest' },
        );
