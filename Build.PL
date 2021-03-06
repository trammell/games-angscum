use strict;
use warnings;
use Module::Build;

my $builder = Module::Build->new(
    module_name => 'Games::Angscum',
    license     => 'perl',
    dist_author => 'John Trammell <johntrammell (at) gmail (dot) com>',
    requires => {
        'parent'           => 0,
        'perl'             => 0,
        'strict'           => 0,
        'warnings'         => 0,
        'AppConfig'        => 0,
        'File::Copy'       => 0,
        'File::HomeDir'    => 0,
        'File::Spec'       => 0,
        'File::Touch'      => 0,
        'File::Which'      => 0,
        'Getopt::Long'     => 0,
        'Module::Build'    => 0,
        'Params::Validate' => 0,
        'Pod::Usage'       => 0,
        'Test::More'       => 0,
    },
    build_requires => {
        'Test::More'            => 0,
        'Module::Build::Compat' => 0,
    },
    recommends => {
        'Test::Script' => 1.06,
        'Test::Warn'   => 0.11,
    },
    recursive_test_files => 1,
    add_to_cleanup       => [qw/ Debian* Games-Angscum-* *.bak /],
    create_readme        => 1,
);

$builder->create_build_script;
