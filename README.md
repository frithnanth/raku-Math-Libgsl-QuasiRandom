[![Build Status](https://travis-ci.org/frithnanth/raku-Math-Libgsl-QuasiRandom.svg?branch=master)](https://travis-ci.org/frithnanth/raku-Math-Libgsl-QuasiRandom)

NAME
====

Math::Libgsl::QuasiRandom - An interface to libgsl, the Gnu Scientific Library - Quasi-Random Sequences.

SYNOPSIS
========

```perl6
use Math::Libgsl::QuasiRandom;

my Math::Libgsl::QuasiRandom $q .= new: :type(SOBOL), :2dimensions;
$q.get».say for ^10;
```

DESCRIPTION
===========

Math::Libgsl::QuasiRandom is an interface to the Quasi-Random Sequences of libgsl, the Gnu Scientific Library.

### new(Int :$type, Int :$dimensions)

The constructor allows two parameters, the quasi-random sequence generator type and the dimensions. One can find an enum listing all the generator types in the Math::Libgsl::Constants module.

### init()

This method re-inits the sequence.

### get(--> List)

Returns the next item in the sequence as a List of Nums.

### name(--> Str)

This method returns the name of the current quasi-random sequence.

### copy(Math::Libgsl::QuasiRandom $src)

This method copies the source generator **$src** into the current one and returns the current object, so it can be concatenated. The generator state is also copied, so the source and destination generators deliver the same values.

### clone(--> Math::Libgsl::QuasiRandom)

This method clones the current object and returns a new object. The generator state is also cloned, so the source and destination generators deliver the same values.

```perl6
my $q = Math::Libgsl::QuasiRandom.new;
my $clone = $q.clone;
```

C Library Documentation
=======================

For more details on libgsl see [https://www.gnu.org/software/gsl/](https://www.gnu.org/software/gsl/). The excellent C Library manual is available here [https://www.gnu.org/software/gsl/doc/html/index.html](https://www.gnu.org/software/gsl/doc/html/index.html), or here [https://www.gnu.org/software/gsl/doc/latex/gsl-ref.pdf](https://www.gnu.org/software/gsl/doc/latex/gsl-ref.pdf) in PDF format.

Prerequisites
=============

This module requires the libgsl library to be installed. Please follow the instructions below based on your platform:

Debian Linux
------------

    sudo apt install libgsl23 libgsl-dev libgslcblas0

That command will install libgslcblas0 as well, since it's used by the GSL.

Ubuntu 18.04
------------

libgsl23 and libgslcblas0 have a missing symbol on Ubuntu 18.04. I solved the issue installing the Debian Buster version of those three libraries:

  * [http://http.us.debian.org/debian/pool/main/g/gsl/libgslcblas0_2.5+dfsg-6_amd64.deb](http://http.us.debian.org/debian/pool/main/g/gsl/libgslcblas0_2.5+dfsg-6_amd64.deb)

  * [http://http.us.debian.org/debian/pool/main/g/gsl/libgsl23_2.5+dfsg-6_amd64.deb](http://http.us.debian.org/debian/pool/main/g/gsl/libgsl23_2.5+dfsg-6_amd64.deb)

  * [http://http.us.debian.org/debian/pool/main/g/gsl/libgsl-dev_2.5+dfsg-6_amd64.deb](http://http.us.debian.org/debian/pool/main/g/gsl/libgsl-dev_2.5+dfsg-6_amd64.deb)

Installation
============

To install it using zef (a module management tool):

    $ zef install Math::Libgsl::QuasiRandom

AUTHOR
======

Fernando Santagata <nando.santagata@gmail.com>

COPYRIGHT AND LICENSE
=====================

Copyright 2020 Fernando Santagata

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

