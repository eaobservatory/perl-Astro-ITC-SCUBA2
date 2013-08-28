use strict;

use Test::More tests => 2;
use Test::Number::Delta within => 2;

use Astro::ITC::SCUBA2 qw/calctime/;

# Test data from running the current version of the online ITC.
our %tests = (
    daisy_1 => [['Daisy', 450, 0.184, 4.0, 45.0], 1624],
    daisy_2 => [['Daisy', 850, 0.710, 4.0, 2.0], 2975],
);

while (my ($test, $data) = each %tests) {
    my ($in, $ref) = @$data;

    my $result = calctime(@$in);

    delta_ok($result, $ref, $test);
}
