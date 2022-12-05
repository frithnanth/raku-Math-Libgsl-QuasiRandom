use v6;

unit module Math::Libgsl::Raw::QuasiRandom:ver<0.0.1>:auth<zef:FRITH>;

use NativeCall;

constant GSLHELPER  = %?RESOURCES<libraries/gslhelper>.absolute;

sub LIB {
  run('/sbin/ldconfig', '-p', :chomp, :out)
    .out
    .slurp(:close)
    .split("\n")
    .grep(/^ \s+ libgsl\.so\. \d+ /)
    .sort
    .head
    .comb(/\S+/)
    .head;
}

class gsl_qrng_type is repr('CStruct') is export {
  has Str             $.name;
  has uint32          $.max_dimension;
  has Pointer[void]   $state_size;
  has Pointer[void]   $init_state;
  has Pointer[void]   $get;
}

class gsl_qrng is repr('CStruct') is export {
  has gsl_qrng_type    $.type;
  has uint32           $.dimension;
  has size_t           $.state_size;
  has Pointer[void]    $.state;
}

# Quasi-Random number generator initialization
sub mgsl_qrng_alloc(int32 $type, uint32 $d --> gsl_qrng) is native(GSLHELPER) is export { * }
sub gsl_qrng_free(gsl_qrng $q) is native(&LIB) is export { * }
sub gsl_qrng_init(gsl_qrng $q) is native(&LIB) is export { * }
# Sampling from a quasi-random number generator
sub gsl_qrng_get(gsl_qrng $q, CArray[num64] $x --> int32) is native(&LIB) is export { * }
# Auxiliary random number generator functions
sub gsl_qrng_name(gsl_qrng $q --> Str) is native(&LIB) is export { * }
sub gsl_qrng_size(gsl_qrng $q --> size_t) is native(&LIB) is export { * }
sub gsl_qrng_state(gsl_qrng $q --> Pointer[void]) is native(&LIB) is export { * }
# Saving and restoring quasi-random number generator state
sub gsl_qrng_memcpy(gsl_qrng $dest, gsl_qrng $src --> int32) is native(&LIB) is export { * }
sub gsl_qrng_clone(gsl_qrng $q --> gsl_qrng) is native(&LIB) is export { * }
