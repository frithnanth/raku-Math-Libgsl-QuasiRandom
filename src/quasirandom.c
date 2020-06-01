#include <stdio.h>
#include <stdlib.h>
#include <gsl/gsl_qrng.h>
#include <gsl/gsl_errno.h>

/* Setup */
gsl_qrng *mgsl_qrng_alloc(int type, unsigned int d)
{
  const gsl_qrng_type *types[] = { gsl_qrng_niederreiter_2, gsl_qrng_sobol, gsl_qrng_halton, gsl_qrng_reversehalton };
  const gsl_qrng_type *T;
  gsl_qrng *q;
  T = types[type];
  q = gsl_qrng_alloc(T, d);
  return q;
}
