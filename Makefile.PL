# $Id$
use ExtUtils::MakeMaker;

WriteMakefile
        (
        'NAME'     => 'Test::Manifest',
        'VERSION'  => '0.5',
		'PREREQ_PM' => {
			'Text::Diff' => undef;
			},
        'PM'       => 
        	{
            'lib/Manifest.pm'     => '$(INST_LIBDIR)/Manifest.pm',
            },
        );
