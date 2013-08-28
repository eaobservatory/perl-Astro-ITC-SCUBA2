#!/usr/bin/env perl

use strict;
use warnings;

use Module::Build;

our %require = (
               );


my $build = new Module::Build(
    module_name    => 'Astro::ITC::SCUBA2',
    license        => 'gpl3',
    requires       => \%require,
    build_requires => {
                       'Test::More' => 0,
                       'Test::Number::Delta' => 0,
                      },
);

$build->create_build_script();
