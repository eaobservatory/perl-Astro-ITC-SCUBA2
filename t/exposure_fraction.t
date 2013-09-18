use strict;

use Test::More tests => 2 * 5;
use Test::Number::Delta within => 1e-8;

use Astro::ITC::SCUBA2 qw/exposure_time_fraction/;

foreach (<DATA>) {
    chomp;
    my ($mode, $c850, $c450) = split;

    delta_ok(exposure_time_fraction($mode, '850'), $c850, $mode . ' 850um');
    delta_ok(exposure_time_fraction($mode, '450'), $c450, $mode . ' 450um');
}

__DATA__
Daisy       0.248312    0.062124
Pong900     0.053870    0.013420
Pong1800    0.014113    0.003500
Pong3600    0.003180    0.000550
Pong7200    0.000794    0.00017919
