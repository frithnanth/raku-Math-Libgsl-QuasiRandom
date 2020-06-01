#!/usr/bin/env raku

# See "GNU Scientific Library" manual Chapter 19 Quasi-Random Sequences, Paragraph 19.6

use lib 'lib';
use Math::Libgsl::QuasiRandom;
use Math::Libgsl::Constants;

my Math::Libgsl::QuasiRandom $q .= new: :type(SOBOL), :2dimensions;
printf("%.5f %.5f\n", $q.get) for ^1024;
