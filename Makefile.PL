# $Id$
use ExtUtils::MakeMaker;

WriteMakefile
        (
        'NAME'     => 'Test::Manifest',
        'VERSION'  => '0.5',
        'PM'       => 
        	{
            'lib/Manifest.pm'     => '$(INST_LIBDIR)/Manifest.pm',
            },
        );
