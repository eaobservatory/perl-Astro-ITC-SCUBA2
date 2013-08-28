use strict;

use Test::More tests => 2;
use Test::Number::Delta within => 0.02;

use Astro::ITC::SCUBA2 qw/calcrms/;

# Test data from running the current version of the online ITC.
our %tests = (
    daisy_1 => [['Daisy', 450, 0.184, 4.0, 810], 63.73],
    daisy_2 => [['Daisy', 850, 0.710, 4.0, 810], 3.83],
);

while (my ($test, $data) = each %tests) {
    my ($in, $ref) = @$data;

    my $result = calcrms(@$in);

    delta_ok($result, $ref, $test);
}
