#!/usr/bin/env raku

# See "GNU Scientific Library" manual Chapter 19 Quasi-Random Sequences, Paragraph 19.6

use lib 'lib';
use Math::Libgsl::Raw::QuasiRandom;
use Math::Libgsl::Constants;
use NativeCall;

my gsl_qrng $q = mgsl_qrng_alloc(SOBOL, 2);
my $res = CArray[num64].allocate(2);
for ^1024 {
  gsl_qrng_get($q, $res);
  printf "%.5f %.5f\n", $res.list;
}
gsl_qrng_free($q);

