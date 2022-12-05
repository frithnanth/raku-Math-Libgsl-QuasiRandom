use v6.c;

unit class Math::Libgsl::QuasiRandom:ver<0.0.1>:auth<zef:FRITH>;

use Math::Libgsl::Raw::QuasiRandom;
use Math::Libgsl::Exception;
use Math::Libgsl::Constants;
use NativeCall;

has gsl_qrng $.q;
has Int      $.dimensions;

submethod BUILD(Int :$type?, Int :$dimensions?, gsl_qrng :$q?) {
  with $q {
    $!q = $q;
    $!dimensions = $dimensions;
  } else {
    $!q = mgsl_qrng_alloc($type // NIEDERREITER2, $dimensions);
    $!dimensions = $dimensions;
  }
}
submethod DESTROY { gsl_qrng_free($!q) }

method init() { gsl_qrng_init($!q) }
method get(--> List) {
  my $res = CArray[num64].allocate($!dimensions);
  my $ret = gsl_qrng_get($!q, $res);
  fail X::Libgsl.new: errno => $ret, error => "Error in get()" if $ret ≠ GSL_SUCCESS;
  return $res.list;
}
method name(--> Str) { gsl_qrng_name($!q) }
method copy(Math::Libgsl::QuasiRandom $src) {
  my $ret = gsl_qrng_memcpy($!q, $src.q);
  fail X::Libgsl.new: errno => $ret, error => "Can't copy the generator" if $ret ≠ GSL_SUCCESS;
  return self;
}
method clone(--> Math::Libgsl::QuasiRandom) {
  Math::Libgsl::QuasiRandom.new: :q(gsl_qrng_clone($!q)), :dimensions($!dimensions);
}

=begin pod

=head1 NAME

Math::Libgsl::QuasiRandom - An interface to libgsl, the Gnu Scientific Library - Quasi-Random Sequences.

=head1 SYNOPSIS

=begin code :lang<raku>

use Math::Libgsl::QuasiRandom;
use Math::Libgsl::Constants;

my Math::Libgsl::QuasiRandom $q .= new: :type(SOBOL), :2dimensions;
$q.get».say for ^10;

=end code

=head1 DESCRIPTION

Math::Libgsl::QuasiRandom is an interface to the Quasi-Random Sequences of libgsl, the Gnu Scientific Library.

=head3 new(Int :$type, Int :$dimensions)

The constructor allows two parameters, the quasi-random sequence generator type and the dimensions. One can find an enum listing all the generator types in the Math::Libgsl::Constants module.

=head3 init()

This method re-inits the sequence.

=head3 get(--> List)

Returns the next item in the sequence as a List of Nums.

=head3 name(--> Str)

This method returns the name of the current quasi-random sequence.

=head3 copy(Math::Libgsl::QuasiRandom $src)

This method copies the source generator B<$src> into the current one and returns the current object, so it can be concatenated.
The generator state is also copied, so the source and destination generators deliver the same values.

=head3 clone(--> Math::Libgsl::QuasiRandom)

This method clones the current object and returns a new object.
The generator state is also cloned, so the source and destination generators deliver the same values.

=begin code :lang<raku>

my $q = Math::Libgsl::QuasiRandom.new;
my $clone = $q.clone;

=end code

=head1 C Library Documentation

For more details on libgsl see L<https://www.gnu.org/software/gsl/>.
The excellent C Library manual is available here L<https://www.gnu.org/software/gsl/doc/html/index.html>, or here L<https://www.gnu.org/software/gsl/doc/latex/gsl-ref.pdf> in PDF format.

=head1 Prerequisites

This module requires the libgsl library to be installed. Please follow the instructions below based on your platform:

=head2 Debian Linux and Ubuntu 20.04+

=begin code
sudo apt install libgsl23 libgsl-dev libgslcblas0
=end code

That command will install libgslcblas0 as well, since it's used by the GSL.

=head2 Ubuntu 18.04

libgsl23 and libgslcblas0 have a missing symbol on Ubuntu 18.04.
I solved the issue installing the Debian Buster version of those three libraries:

=item L<http://http.us.debian.org/debian/pool/main/g/gsl/libgslcblas0_2.5+dfsg-6_amd64.deb>
=item L<http://http.us.debian.org/debian/pool/main/g/gsl/libgsl23_2.5+dfsg-6_amd64.deb>
=item L<http://http.us.debian.org/debian/pool/main/g/gsl/libgsl-dev_2.5+dfsg-6_amd64.deb>

=head1 Installation

To install it using zef (a module management tool):

=begin code
$ zef install Math::Libgsl::QuasiRandom
=end code

=head1 AUTHOR

Fernando Santagata <nando.santagata@gmail.com>

=head1 COPYRIGHT AND LICENSE

Copyright 2020 Fernando Santagata

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

=end pod
