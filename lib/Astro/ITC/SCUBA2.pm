=head1 NAME

Astro::ITC::SCUBA2 - SCUBA-2 Integration Time Calculator

=head1 SYNOPSIS

    use Astro::ITC::SCUBA2 qw/@obsmodes %obstypes calctime calcrms/;

=head1 DESCRIPTION

This module contains SCUBA-2 integration time calculation
functions extracted from the online SCUBA-2 integration time
calculator.

=cut

package Astro::ITC::SCUBA2;

use strict;

use base 'Exporter';

our $VERSION = 0.01;

our @EXPORT_OK = qw/@obsmodes %obstypes calctime calcrms
                    exposure_time_fraction/;

=head1 DATA

=over 4

=item @obsmodes

A list of supported SCUBA-2 observing modes, which
are the keys of the L<%obstypes> hash.

=cut

our @obsmodes = ( 'Daisy', 'Pong900', 'Pong1800', 'Pong3600', 'Pong7200' );

=item %obstypes

Observing parameters: timing parameters are for an equation like

    T_elapse[sec] = [ (tA/transmission + tB) / rms[mJy/beam] ]**2

Each entry is another hash containing:

    help:         description of the mode
    tA850, tB850: timing parameters for 850um calculations
    tA450, tA450: timing parameters for 450um calculations
    c850, c450:   exposure time fraction of elapsed time

Where c is defined as:

    T_exposure = c * T_elapse

Note that the tA and tB values include c so this data structure
would probably be better not containing both as a function of mode.

=cut

our %obstypes;
foreach my $obstype ( @obsmodes ) {

   my %ref;
   $ref{name}  = $obstype;

   if ( $obstype eq 'Daisy' ) {
     $ref{help}  = 'Daisy: ~3 arcmin map';
     $ref{tA850} =  189; $ref{tB850} =  -48;
     $ref{tA450} =  689; $ref{tB450} = -118;
     $ref{c850}  = 0.248312; $ref{c450} = 0.062124;
   } elsif ( $obstype eq 'Pong900' ) {
     $ref{help}  = 'Pong900: 15 arcmin map',
     $ref{tA850} =  407; $ref{tB850} = -104;
     $ref{tA450} = 1483; $ref{tB450} = -254;
     $ref{c850}  = 0.053870; $ref{c450} = 0.013420;
   } elsif ( $obstype eq 'Pong1800' ) {
     $ref{help}  = 'Pong1800: 30 arcmin map';
     $ref{tA850} =  795; $ref{tB850} = -203;
     $ref{tA450} = 2904; $ref{tB450} = -497;
     $ref{c850}  = 0.014113; $ref{c450} = 0.003500;
   } elsif ( $obstype eq 'Pong3600' ) {
     $ref{help}  = 'Pong3600: 1 degree map';
     $ref{tA850} = 1675; $ref{tB850} = -428;
     $ref{tA450} = 6317; $ref{tB450} = -1082;
     $ref{c850}  = 0.003180; $ref{c450} = 0.000550;
   } elsif ( $obstype eq 'Pong7200' ) {
     $ref{help}  = 'Pong7200: 2 degree map';
     $ref{tA850} = 3354; $ref{tB850} = -857;
     $ref{tA450} = 12837; $ref{tB450} = -2200;
     $ref{c850}  = 0.000794; $ref{c450} = 0.00017919;
   }

   $obstypes{$obstype} = \%ref;
}

=back

=head1 SUBROUTINES

=over 4

=item calctime

Calculate the observing time. Parameters are observing type, wavelength
(450/850), transmission, factor, target rms (mJy/beam).

=cut

sub calctime {

  my ( $obstype, $flt, $trans, $factor, $rms ) = @_;

  my $tA = $obstypes{$obstype}->{"tA$flt"};
  my $tB = $obstypes{$obstype}->{"tB$flt"};
  my $sqrttime = ( $tA/$trans+$tB ) / $rms;

  return( $sqrttime*$sqrttime / $factor );
}

=item calcrms

Calculate the rms. Parameters are observing type, wavelength
(450/850), transmission, factor, observing time.

=cut

sub calcrms {

  my ( $obstype, $flt, $trans, $factor, $time ) = @_;

  my $tA = $obstypes{$obstype}->{"tA$flt"};
  my $tB = $obstypes{$obstype}->{"tB$flt"};

  my $rms = ( $tA/$trans+$tB ) / sqrt($factor*$time);

  return( $rms );
}

=item exposure_time_fraction

Returns the ratio, c, of the exposure time to the elapsed time.

    T_exposure = c * T_elapse

=cut

sub exposure_time_fraction {
  my ($obstype, $flt) = @_;

  return $obstypes{$obstype}->{'c' . $flt};
}

1;

=back

=head1 AUTHOR

Remo Tilanus <rtilanus@jach.hawaii.edu>
Graham Bell <g.bell@jach.hawaii.edu>

=head1 COPYRIGHT

Copyright (C) 2013 Science and Technology Facilities Council.

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
