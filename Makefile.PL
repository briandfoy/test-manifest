# $Id$
use ExtUtils::MakeMaker;

WriteMakefile
        (
        'NAME'     => 'Test::Manifest',
        'VERSION'  => '0.7',
		'PREREQ_PM' => {
			'File::Find::Rule' => '0',
			'Test::Data'       => '0',
			'Test::More'       => '0',
			'Test::Pod'        => '0',
			'Test::Prereq'     => '0',
			'Text::Diff'       => '0',
			},
        'PM'       => 
        	{
            'lib/Manifest.pm'  => '$(INST_LIBDIR)/Manifest.pm',
            },
        );
