################
# Created by: setitesuk
# Created on: 2010-06=24

use strict;
use warnings;
use Module::Build;
use lib qw(. lib);

our $VERSION = 0.1;

my $builder = Module::Build->new(
				 module_name         => 'File::Spit',
				 dist_author         => q(Andy Brown <setitesuk@gmail.com>),
				 dist_version        => $VERSION,
				 dist_abstract       => q[Module which will export the spit method for writing out to a file],
				 license             => 'lgpl3',
				 requires            => {
				  'Carp' => 1.04,
				  'English' => 1.02,
				  'Readonly' => '1.03',
				  'FileHandle' => 0,
				  'Test::More' => 0.74,
          'Test::Exception' => 0,
          'Exporter' => 0,
          'base' => 0,
				 },
				 recommends          => {
							},
				 build_requires      => {
							 'Test::More' => '0.8',
               'Test::Exception' => 0,
               'File::Temp' => 0,
               'Perl6::Slurp' => 0,
							},
				 build_recommends    => {
							 'Test::Cmd' => '1.05',
							 'Test::File' => '1.28',
							 'Test::Perl::Critic' => 0,
							 'Test::Distribution' => 0,
							 'Test::Kwalitee' => 0,
							 'Test::Pod' => 0,
							 'Test::Pod::Coverage' => 1.00,
							 
							},
				 create_makefile_pl  => 'small',
				 configure_requires  => { 'Module::Build' => 0.3603 }
				);

$builder->create_build_script();
