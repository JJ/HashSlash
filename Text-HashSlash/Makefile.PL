use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME                => 'Text::HashSlash',
    AUTHOR              => 'JJ Merelo <jj@merelo.net>',
    VERSION_FROM        => 'lib/Text/HashSlash.pm',
    ABSTRACT_FROM       => 'lib/Text/HashSlash.pm',
    PL_FILES            => {},
    PREREQ_PM => {
        'Test::More' => 0,
        'version'    => 0,
	'File::Slurp' => 0,
	'Cwd' => 0,
	'Text::Aspell' => 0
    },
    dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean               => { FILES => 'Text-HashSlash-*' },
);
