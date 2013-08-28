#!/bin/bash

cat <<END
Astro::ITC::SCUBA2
=================

END

perl -MPod::Usage -e 'pod2usage(-input=>"lib/Astro/ITC/SCUBA2.pm",-verbose=>99,-sections=>["DESCRIPTION"])' | sed -e '1d'

#cat <<END
#
#Requirements
#------------
#
#END
#
#perl -e 'local $\ = "\n"; $INC{"Module/Build.pm"} = 1; do "Build.PL"; print "    ", $_ foreach sort keys %require;'

cat <<END

Building
--------

    perl Build.PL
    ./Build
    ./Build test
    ./Build install

Authors
-------

END

perl -MPod::Usage -e 'pod2usage(-input=>"lib/Astro/ITC/SCUBA2.pm",-verbose=>99,-sections=>["AUTHOR"])' | sed -e '1d'

cat <<END

Copyright
---------

END

perl -MPod::Usage -e 'pod2usage(-input=>"lib/Astro/ITC/SCUBA2.pm",-verbose=>99,-sections=>["COPYRIGHT"])' | sed -e '1d'
