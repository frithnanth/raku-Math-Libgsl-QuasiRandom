#!/usr/bin/gnuplot

set term qt persist
set xrange [0:1]
set yrange [0:1]
set grid
plot '< examples/quasi-random.raku' title '' with points pointtype 7 pointsize .5
